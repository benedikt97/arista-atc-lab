from ansible.parsing.dataloader import DataLoader
from ansible.inventory.manager import InventoryManager
from graphviz import Digraph
from flask import Flask, Response
import threading
import requests
import json
import urllib3

app = Flask(__name__)

# Globals
inventory_path = "inventory.yml"
group_name = "FABRIC"
username = "admin"
password = "admin"
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


def execute_command(hostname: str, cmd: str) -> dict:
    url = f"https://{hostname}/command-api"
    payload = {
        "jsonrpc": "2.0",
        "method": "runCmds",
        "params": {
            "version": 1,
            "cmds": [{"cmd": "enable", "input": password}, cmd],
            "format": "json",
        },
        "id": 1,
    }
    response = requests.post(
        url,
        data=json.dumps(payload),
        auth=(username, password),
        verify=False,  # only disable if you use self‑signed certs
    )
    result = response.json()
    result["hostname"] = hostname
    return result

def get_hosts():
    inventory = InventoryManager(DataLoader(), sources=[inventory_path])
    group = inventory.groups.get(group_name)
    if group:
        hosts = [h.name for h in group.get_hosts()]
        print(hosts)
    else:
        print("Group not found")
    return hosts


def get_information(hosts):
    results = []

    for h in hosts:
        result = {}
        result["BGP"] = execute_command(h, "show bgp summary")
        result["BGP_PEERS"] = execute_command(h, "show bgp neighbors")
        result["MAC"] = execute_command(h, "show mac address-table count")
        result["HOSTNAME"] = h
        results.append(result)
    return results

def count_macs(data):
    vlan_counts = data["result"][1]["vlanCounts"]

    total_dynamic = 0
    total_unicast = 0
    total_multicast = 0

    for vlan, counts in vlan_counts.items():
        total_dynamic += counts.get("dynamic", 0)
        total_unicast += counts.get("unicast", 0)
        total_multicast += counts.get("multicast", 0)

    return f"D: {total_dynamic} U{total_unicast}"


@app.route("/")
def render():
    hosts = get_hosts()
    infos = get_information(hosts)
    dot = Digraph("bgp_topology", format="png", engine="sfdp")
    dot.attr(rankdir="TB")
    dot.attr("node", shape="box", style="filled", fillcolor="lightgrey")
    dot.graph_attr.update({
    "sep": "+20",
    "dpi": "150"
    })
    for info in infos:
        bgp_information = info["BGP"]
        bgp_peer_information = info["BGP_PEERS"]
        mac_information = info["MAC"]
        hostname = info["HOSTNAME"]
        print(mac_information)
        try:
            router = bgp_information["result"][1]["vrfs"]["default"]
            peers = bgp_peer_information["result"][1]["vrfs"]["default"]["peerList"]
        except:
            continue
        try:
            mac_count = count_macs(mac_information)
        except:
            mac_count = 0
        router_id = router["routerId"]


        dot.node(router_id, label=f"{hostname}\nASN {router['asn']}\n MAC {mac_count}")

        # Add neighbour nodes and edges
        for peer in peers:
            if "ipv4Unicast" in peer["afiSafiInfo"]:
                bgp_type = "ipv4Unicast"
                
            elif "l2VpnEvpn" in peer["afiSafiInfo"]:
                bgp_type = "l2VpnEvpn"
                continue
            else:
                continue
            state = peer["peerTcpInfo"]["state"]
            peer_router_id = peer["routerId"]
            color = "green" if state == "ESTABLISHED" else "red"
            dot.edge(router_id, peer_router_id, label=f"{state}", color=color)

    output_path = "./bgp_graph.png"
    dot.render(output_path, cleanup=True)
    png = dot.pipe(format="png")
    return Response(png, mimetype="image/png")

def run():
    app.run(host="127.0.0.1", port=8080)


if __name__ == "__main__":
    run()



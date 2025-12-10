from ansible.parsing.dataloader import DataLoader
from ansible.inventory.manager import InventoryManager
from graphviz import Digraph
import requests
import json
import urllib3




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
            "cmds": [
                {"cmd": "enable", "input": password},
                cmd
            ],
            "format": "json"
        },
        "id": 1
    }
    response = requests.post(
        url,
        data=json.dumps(payload),
        auth=(username, password),
        verify=False   # only disable if you use self‑signed certs
    )
    result = response.json()
    result['hostname'] = hostname
    return result

def render(bgp_results: list):
    dot = Digraph("bgp_topology", format="png")
    dot.attr(rankdir="TB")
    dot.attr("node", shape="box", style="filled", fillcolor="lightgrey")

    for data in bgp_results:
        print(data)
        try:
            router = data["result"][1]["vrfs"]["default"]
        except:
            continue
        router_id = router["routerId"]
        peers = router["peers"]
        hostname = data["hostname"]
        print(hostname)
        dot.node(router['asn'], label=f"{hostname}\nASN {router['asn']}")

        # Add neighbour nodes and edges
        for neigh_ip, info in peers.items():
            if "ipv4Unicast" not in info:
                continue
            state = info["peerState"]
            asn = info["peerAsn"]
            dot.node(asn, label=f"{hostname}\nASN {asn}")
            color = "green" if state == "Established" else "red"
            dot.edge(router['asn'], asn, label=state, color=color)


    output_path = "./bgp_graph.png"
    dot.render(output_path, cleanup=True)




if __name__ == '__main__':
    inventory = InventoryManager(DataLoader(), sources=[inventory_path])
    group = inventory.groups.get(group_name)
    if group:
        hosts = [h.name for h in group.get_hosts()]
        print(hosts)
    else:
        print("Group not found")

    results = []
    for h in hosts:
        r = execute_command(h, "show bgp summary")
        results.append(r)
    
    render(results)


1. Enter venv (or create venv and install requirements.txt)
```
. .venv/bin/activate
```
2. Build config
```
ansible-playbook playbooks/build.yml
```
3. Start CLAB
```
clab/do
```
4. Valdiate CLAB
```
testscripts/test.sh
```
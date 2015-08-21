#!/bin/bash
set -e

VENV=${INFRA_ANSIBLE_VENV:-"venv"}

mkdir -p ${VENV}
virtualenv ${VENV}
curl -O https://bootstrap.pypa.io/get-pip.py
source ${VENV}/bin/activate
python get-pip.py
pip install -r "$(dirname $0)/requirements.txt"
pip install git+https://github.com/ansible/ansible.git@devel
# XXX: Have to symlink ansible -> ansible-playbook to get working
pushd venv/bin/
ln -sf ansible ansible-playbook
popd
# XXX: Only way to get the openstack.py plugin
git clone https://github.com/ansible/ansible.git


echo ========================================================================
echo If you have elected to provide cloud provider details via environment
echo variables, source that file.  Otherwise, we assume you are managing that
echo information with os-client-config and in that case, replace 'envvars' in
echo your infra_config.yaml file with the name of a cloud provider you have
echo ========================================================================

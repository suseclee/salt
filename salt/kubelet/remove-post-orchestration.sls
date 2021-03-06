{%- set target = salt.caasp_pillar.get('target') %}
{%- set forced = salt.caasp_pillar.get('forced', False) %}

{%- set nodename = salt.caasp_net.get_nodename(host=target) %}

###############
# k8s cluster
###############

{%- set k8s_nodes = salt.caasp_nodes.get_with_expr('P@roles:(kube-master|kube-minion)', booted=True)|list %}
{%- if forced or target in k8s_nodes %}

include:
  - kubectl-config

{%- from '_macros/kubectl.jinja' import kubectl with context %}

{{ kubectl("remove-node",
           "delete node " + nodename) }}

{% else %}

remove-post-orchestration-dummy:
  cmd.run:
    - name: "echo saltstack bug 14553"

{% endif %}

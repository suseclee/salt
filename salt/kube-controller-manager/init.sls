include:
  - repositories
  - kubernetes-common

kube-controller-manager:
  file.managed:
    - name:       /etc/kubernetes/controller-manager
    - source:     salt://kube-controller-manager/controller-manager.jinja
    - template:   jinja
    - require:
      - pkg:      kubernetes-master
  service.running:
    - enable:     True
    - watch:
      - sls:      kubernetes-common
      - file:     kube-controller-manager

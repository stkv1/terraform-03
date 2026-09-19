[webservers]
%{ for i, vm in web_vms ~}
${vm.name} ansible_host=${vm.nat_ip} fqdn=${vm.fqdn}
%{ endfor ~}

[databases]
%{ for k, vm in app_vms ~}
${vm.name} ansible_host=${vm.nat_ip} fqdn=${vm.fqdn}
%{ endfor ~}

[storage]
${storage_vm.name} ansible_host=${storage_vm.nat_ip} fqdn=${storage_vm.fqdn}

# resource "local_file" "hosts_inventory" {
#   filename = "${path.root}/../ansible/playbook/inventory/hosts.ini"

#   content = trimspace(<<-EOT
# %{if length(local.hosts) > 0}
# [webservers]
# %{for h in local.hosts}
# ${h.name} ansible_host=${h.ip} ansible_user=${h.user}
# %{endfor}
# %{endif}
# EOT
#   )
# }

resource "local_file" "hosts_inventory" {
  filename = "${path.root}/../ansible/playbook/inventory/hosts.ini"

  content = trimspace(<<-EOT
%{if length(local.hosts) > 0}
%{for h in local.hosts}
[${h.user}]
${h.name} ansible_host=${h.ip} ansible_user=${h.user}
%{endfor}
%{endif}
EOT
  )
}

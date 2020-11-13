pCli=8101
pGui=8181
pOF=6633

function cont_ip(){
    docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$1"
}

#connect to cli of specified onos node
function onos_cli(){
	ipAddress=$(cont_ip $1)
	ssh-keygen -f "/home/sdn/.ssh/known_hosts" -R "[$ipAddress]:$pCli"
	ssh -p "$pCli" karaf@"$ipAddress"
}

#run gui of specified onos node
function onos_gui(){
	ipAddress=$(cont_ip $1)
	firefox http://"$ipAddress":"$pGui"/onos/ui
}

# #REST API documentation for onos instance
function onos_rest_doc(){
        ipAddress=$(cont_ip $1)
        firefox http://$ipAddress:$pGui/onos/v1/docs/
}
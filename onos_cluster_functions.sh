pCli=8101
pGui=8181
pOF=6633

function cont_ip(){
    docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$1"
}

function valid_ip(){
	ip route get $1 &> /dev/null
}

function parse_arg(){
	if valid_ip $1;
	then
		ipAddress=$1
		echo Using IP address: "$1"
	else
		ipAddress=$(cont_ip $1)
		echo Using container name: "$1"
	fi
}

#connect to cli of specified onos node
function onos_cli(){
	parse_arg $1
	ssh-keygen -f "/home/sdn/.ssh/known_hosts" -R "[$ipAddress]:$pCli"
	ssh -p "$pCli" karaf@"$ipAddress"
}

#run gui of specified onos node
function onos_gui(){
	parse_arg $1
	firefox http://"$ipAddress":"$pGui"/onos/ui
}

# #REST API documentation for onos instance
function onos_rest_api(){
    parse_arg $1
    firefox http://$ipAddress:$pGui/onos/v1/docs/
}
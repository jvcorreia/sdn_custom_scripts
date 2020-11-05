#!/bin/bash

#run mininet with ordered mac addresses with ovs switches running OF14 with onos cluster 
#use as follows: mn_onos <name of onos 1 container> ... <name of onos n container> --topo <topology>
#example: mn_onos


comd="sudo mn --mac --switch=ovs,protocols=OpenFlow14 "
for(( arg=1; arg <= "$#"; arg++))
do
	if [[ "${!arg}" == "onos"* ]]
	then
		ipAddr=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "${!arg}")
		ctrlr="--controller=remote,ip=$ipAddr,port=$pOF "
		comd="$comd$ctrlr"
	elif [[ "${!arg}" == "--topo" ]]
	then
		arg=$((arg+1))
		topo=${!arg}
		comd="$comd--topo $topo"
	fi		
done
eval "$comd"
#!/bin/bash

#VERY VERY simple script to erase the onos cluster. It basically erases all containers running onos and atomix docker images


#get a list of all containers
container_list=$(docker ps -a --format "{{.Names}}")

#iterate over that list
for cont_name in ${container_list[@]}
do
	#get the docker image name of the container
	image_name=$(docker inspect --format='{{.Config.Image}}' $cont_name)
	
	#if the container image is an onos or atomix image of any version
	if [[ "$image_name" == "onosproject/onos:"* || "$image_name" == "atomix/atomix:"* ]] 
	then
		echo "Stoping $cont_name container ..."
		docker container stop $cont_name >> /dev/null	#stop that container
		
		echo "Removing $cont_name container ..."
		docker container rm -f $cont_name >> /dev/null	#remove that container
		
		echo "Done"
	fi
done

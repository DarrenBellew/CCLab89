read -p "Press [Enter] key to check connection"

curl -s -X GET -H 'Accept: application/json' http://localhost:8081

read -p "Press [Enter] key to list all containers..."

curl -s -X GET -H 'Accept: application/json' http://localhost:8081/containers | python -mjson.tool

read -p "Press [Enter] key to List running containers..."

curl -s -X GET -H 'Accept: application/json' http://localhost:8081/containers?state=running | python -mjson.tool

read -p "Press [Enter] key to inspect a container"
read container -p "Please enter a container id: "

curl -s -X GET -H 'Accept: application/json' http://localhost:8081/containers/$container

read -p "Press [Enter] key to Delete a container..."

read container -p "Please enter a container id: "
curl -s -X DELETE -H 'Accept: application/json' http://localhost:8081/containers/$container

read -p "Press [Enter] key to delete all containers..."

#Delete all container code
echo "curl -s -X DELETE -H 'Accept: application/json' 83.212.127.223:8081/containers"
echo "docker stop $(docker ps -a -q)"
echo "docker rm $(docker ps -a -q)"

echo "output = docker('stop', docker('ps','-a','-q'))"
echo "output2 = docker('rm', docker('ps', '-a', '-q'))"

read -p "Press [Enter] key to create a container from an image..."
read imageID -p "Please enter an image id to create a container from: "
curl -X POST -H 'Content-Type: application/json' http://localhost:8081/containers -d '{"image": "$imageID"}'

read "Press [Enter] key to restart a container"
read containerID -p "Please ender a container id to restart"
curl -X PATCH -H 'Content-Type: application/json' http://localhost:8080/containers/$containerID -d '{"state": "running"}'

read -p "Press [Enter] key to stop a container..."
read contianerID -p "Please enter a container id to stop "
curl -X PATCH -H 'Content-Type: application/json' http://localhost:8080/containers/$containerID -d '{"state": "stopped"}'

read -p "Press [Enter] key to show logs from a container..."
read containerID -p "Please enter a container id to show logs: "
curl -s -X GET -H 'Accept: application/json' 83.212.127.223:8081/containers/$containerID/logs


read -p "Press [Enter] key to List all images..."
curl -s -X GET -H 'Accept: application/json' 83.212.127.223:8081/images

read -p "Press [Enter] key to Delete an image..."
read imageID -p "Press [Enter] key to Delete an imageID: "
curl -s -X DELETE -H 'Accept: application/json' 83.212.127.223:8081/images/$imageID

read -p "Press [Enter] key to Delete ALL Images..."
echo "curl -s -X DELETE -H 'Accept: application/json' 83.212.127.223:8081/images/<id>"
echo "docker ('rmi', id)"

read -p "Press [Enter] key to TAG an image..."
read imageID -p "Enter an imageID to tag: "
curl -s -X PATCH -H 'Content-Type: application/json' http://localhost:8081/images/$imageID -d '{"tag": "test:1.0"}'

read -p "Press [Enter] key to create Docker Images from local docker file..."
read path -p "Please enter file path/name (no need for ./) of file: "
curl -H 'Accept: application/json' -F file=@$path http://localhost:8080/images
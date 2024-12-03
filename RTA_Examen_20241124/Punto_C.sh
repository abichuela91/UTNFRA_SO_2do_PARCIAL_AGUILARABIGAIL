#!/bin/bash
#despues de haber instalado Docker se accede con usuario y token generado
docker login -u milka445
Password:  
# se modifica el archivo index.html con lo pedio en el parcial
vim index.html

# se crea y edita el archivo dockerfile 

vim Dockerfile
#FROM nginx:latest
#COPY index.html /usr/share/nginx/html
 
docker image list
# con este comando se publica 
docker push milka445/web1aguilar:latest

# se crea y se edita un archivo run.sh con el comando a ejecutar en el puerto 8080
vim run.sh
#docker run -d -p 8080:80 milka445/web1aguilar:latest

sudo chmod 764 run.sh # se cambia los permisos de ejecucion al archivo run.sh
./run.sh # se ejecuta el comando
docker ps
curl localhost:8080


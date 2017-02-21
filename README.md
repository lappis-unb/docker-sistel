# docker-sistel
Dockerfile e afins do container do sistel 

## Como rodar

1. docker build .

2. docker run -it -p 8080:8080 -v DIRETORIO-WAR:/opt/jboss/wildfly/standalone/deployments/ IDIMAGEM

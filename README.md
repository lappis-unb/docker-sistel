# docker-sistel
Dockerfile e afins do container do sistel 

## Como rodar

1. docker build .

2. docker run -it -p 8080:8080 -v DIRETORIO-WAR:/opt/jboss/wildfly/standalone/deployments/ IDIMAGEM

## Conexão com bancos

Atualmente estamos adicionando um host local.db que aponta para outro container com o banco de dados, para mudar o ip basta editar o arquivos src/addHosts.sh

## Log

localização do log dentro do container: /opt/jboss/wildfly/standalone/log/server.log

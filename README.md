# docker-sistel
Dockerfile e afins do container do sistel 

## Como rodar

1. Construa a imagem do docker, chame ela de sistel :D
```
docker build -t sistel .
```
2. Rode o container à partir da imagem sistel (container vai chamar sistel também)
```
docker run -id --name sistel -p 80:8080 -e ENVDB=$ENVDB -e USERDB=$USERDB -e PASSDB=$PASSDB -e LDAPURL=$LDAPURL -e LDAPBASE=$LDAPBASE -e LDAPUSERDN=$LDAPUSERDN -e LDAPPASS=$LDAPPASS -e LDAPUSERSEARCHBASE=$LDAPUSERSEARCHBASE -e LDAPUSERSEARCHFILTER=$LDAPUSERSEARCHFILTER -e ENVMAILHOST=$ENVMAILHOST -e ENVMAILPORT=$ENVMAILPORT -e ENVMAILPROTOCOL=$ENVMAILPROTOCOL -e ENVSMTPAUTH=$ENVSMTPAUTH -e ENVTLSENABLE=$ENVTLSENABLE -e ENVMAILDEBUG=$ENVMAILDEBUG -e ENVMAILTIMEOUT=$ENVMAILTIMEOUT -e SEISERVICO=$SEISERVICO -e SEISISTEMA=$SEISISTEMA -e SEIURL=$SEIURL -v [Pasta para WAR]:/opt/jboss/wildfly/standalone/deployments/ -v [Pasta para as Faturas Carregadas]:/opt/jboss/upload-dir/ -v [Pasta para LOG]:/opt/jboss/wildfly/standalone/log/   sistel:$GIT_COMMIT
```

Obs: as variáveis de ambiente acima precisam ser definidas, lista abaixo detalhada.

## Conexão com bancos

Ao setar a variável ENVDB com o ip ou o nome do host, será necessário adicionar o mapeamento de host no arquivo src/addHosts.sh

## Log

localização do log dentro do container: /opt/jboss/wildfly/standalone/log/server.log

## Faturas
 
 As faturas são armazenadas na pasta upload-dir durante a carga da base de dados
 
## War file

O arquivo war da aplicação devera ser movido para a pasta compartilhada com a /opt/jboss/wildfly/standalone/deployments/

## Variavéis de ambiente listadas a baixo:

  1. Banco de Dados (Local/Docker)

    1.1 Chamada arquivo application.propreties
  
      1.1.1 Mysql
        spring.datasource.url= jdbc:mysql://${ENVDB}:3306/dbditel
        spring.datasource.username= ${USERDB}
        spring.datasource.password= ${PASSDB}

      1.1.2 Postegres
        spring.datasource.driver-class-name= org.postgresql.Driver
        spring.datasource.url= jdbc:postgresql://${ENVDB}:5432/dbditel
        spring.datasource.username= ${USERDB}
        spring.datasource.password= ${PASSDB}

	  1.2 Variáveis ambiente
        ENVDB = Ip da base
        USERDB = Usuário da base
        PASSDB = Senha da base

  2. Serviço Email

    2.1 Chamada arquivo application.propreties
      email.host= ${ENVMAILHOST}
      email.port= ${ENVMAILPORT}
      email.protocol= ${ENVMAILPROTOCOL}
      email.smtp.aut= ${ENVSMTPAUTH}
      email.tls.enable= ${ENVTLSENABLE}
      email.debug= ${ENVMAILDEBUG}
      email.timeout= ${ENVMAILTIMEOUT}

    2.2  Variáveis ambiente
      ENVMAILHOST= mailapp.xxx.xxx.xxx
      ENVMAILPORT= 25
      ENVMAILPROTOCOL= smtp
      ENVSMTPAUTH= true
      ENVTLSENABLE= true
      ENVMAILDEBUG= false
      ENVMAILTIMEOUT= 50000

3. LDAP(Configuração de Autenticação e consulta)*

  3.1 Chamada arquivo application.propreties
  
      ldap.userDn= ${LDAPUSERDN}
      ldap.passDn= ${LDAPPASS}
      ldap.url= ${LDAPURL}
      ldap.base= ${LDAPBASE}
      ldap.user.search.filter= ${LDAPUSERSEARCHFILTER}
      ldap.user.search.base= ${LDAPUSERSEARCHBASE}

 3.2 Variáveis ambiente
 
       LDAPUSER= Usuario de login
       LDAPPASS= Senha 
       LDAPUSERDN= CN=Usuariologin,OU=XXXXX,OU=YYYYY,OU=ZZZZZ
       LDAPURL= ldap://000.000.000:389
       LDAPBASE= DC=XXXXX,DC = XXXX
       LDAPUSERSEARCHFILTER= XXXXXXXXXXXX
       LDAPUSERSEARCHBASE= XXXXXXXXXXXX
      
### Configurar o SEI (Sistema Eletrônico de Informação) para comunicação via WEBSERVICE:

    1. Operações requisitadas
        -Gerar Procedimento
        -Listar Usuarios Com Permissões na Unidade
        -Consultar Documento
        -Consultar Procedimento
        -Incluir Documento
        -Incluir Documento em Bloco
        -Disposnibilizar Bloco
        -Gerar Bloco
        -Excluir BlocoRetirar 
        -Documento de Bloco
        -Cancelar Disponibilização de Bloco

    2. Chamada arquivo application.propreties
       sei.sistema= ${SEISISTEMA}
       sei.servico= ${SEISERVICO}

    3. Variáveis ambiente
      SEISISTEMA = REGISTRO NO SEI DA APLICAÇÃO
      SEISERVICO = REGISTRO NO SEI DA APLICAÇÃO
      SEIURL =  Url do sei a ser utilizado via WebService(Homolog, Treinamento , Produção ou etc.)
    
    4 Alterar arquivo pom.xml
	    - Na TAG <build> alterar a tag <url>http://xxxxx.xxxxx.xxx.xx/sei/controlador_ws.php?servico=sei</url> para o endereço do controlador do SEI.

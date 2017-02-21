FROM jboss/wildfly

# habilitar para criar usuário admin
#RUN /opt/jboss/wildfly/bin/add-user.sh admin Admin#70365

#habilitar para funcionar interface de administração
#CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

# habilitar caso queira adicionar o arquivo na mao, ao invés de mapear o volume
#ADD war/Sistel.war /opt/jboss/wildfly/standalone/deployments/

# onde o war eh gerado -> /home/chris/projetos/sistel/target/
#VOLUME ["/home/chris/projetos/docker-sistel/war" , "/opt/jboss/wildfly/standalone/deployments/"]

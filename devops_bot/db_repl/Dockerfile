FROM postgres:15

RUN mkdir -p /var/log/postgresql && chown -R postgres:postgres /var/log/postgresql

COPY init_db.sql       /docker-entrypoint-initdb.d/
COPY standby.conf      /tmp/standby.conf
COPY modify-configs.sh /docker-entrypoint-initdb.d/
RUN  chmod +x          /docker-entrypoint-initdb.d/modify-configs.sh


COPY entrypoint.sh /usr/local/bin/
RUN  chmod +x      /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

FROM postgres:15

RUN mkdir -p /var/log/postgresql && chown -R postgres:postgres /var/log/postgresql

RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo && \
    rm -rf /var/lib/apt/lists/*


COPY init_db.sql              /tmp/init_db.sql
RUN  chown postgres:postgres  /tmp/init_db.sql

COPY postgresql.conf /tmp/postgresql.conf

COPY modify-configs.sh /docker-entrypoint-initdb.d/
RUN  chmod +x          /docker-entrypoint-initdb.d/modify-configs.sh

COPY view-log.sh /tmp/
RUN  chmod +x    /tmp/view-log.sh

COPY entrypoint.sh /usr/local/bin/
RUN  chmod +x      /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

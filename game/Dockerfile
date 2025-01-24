FROM postgres:15

ENV POSTGRES_DB=stardew_db
ENV POSTGRES_USER=stardew_user
ENV POSTGRES_PASSWORD=stardew_pass

COPY ./init.sh /docker-entrypoint-initdb.d/init.sh
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

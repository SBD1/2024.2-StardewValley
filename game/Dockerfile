FROM postgres:15

ENV POSTGRES_DB=stardew_db
ENV POSTGRES_USER=stardew_user
ENV POSTGRES_PASSWORD=stardew_pass

COPY ./db/ /docker-entrypoint-initdb.d/

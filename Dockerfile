FROM elixir:latest
RUN apt-get update && \
    apt-get install -y postgresql-client && \
    apt-get install -y inotify-tools && \
    mix local.hex --force && \
    mix archive.install hex phx_new 1.6.2 --force && \
    mix local.rebar --force
WORKDIR /app

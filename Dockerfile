FROM elixir:latest

ENV MIX_ENV prod

ENV PORT 4000

RUN mix local.hex --force && \
    mix local.rebar --force && \
    curl -sL https://deb.nodesource.com/setup_7.x | bash && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install nodejs yarn -y

ADD . .

RUN make setup

CMD ["make"]

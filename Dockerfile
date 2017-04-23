FROM asia.gcr.io/labs-127/confession:base

ADD . .

RUN make setup

CMD ["make"]

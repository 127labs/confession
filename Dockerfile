FROM asia.gcr.io/labs-127/confession:base

ARG FB_PAGE_ACCESS_TOKEN
ARG FB_VERIFICATION_TOKEN

ADD . .

RUN make setup

CMD ["make"]

FROM asia.gcr.io/labs-127/confession:base

ARG FB_PAGE_ACCESS_TOKEN
ARG FB_VERIFICATION_TOKEN
ARG SECRET_KEY_BASE

ADD . .

RUN make setup

CMD ["make"]

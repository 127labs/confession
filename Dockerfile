FROM asia.gcr.io/labs-127/confession:base

ENV FB_PAGE_ACCESS_TOKEN
ENV FB_VERIFICATION_TOKEN

ADD . .

RUN make setup

CMD ["make"]

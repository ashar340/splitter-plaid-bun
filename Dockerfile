FROM debian:11.6-slim as builder

WORKDIR /splitter-plaid-bun

RUN apt update
RUN apt install curl unzip -y

RUN curl https://bun.sh/install | bash

COPY package.json .
COPY bun.lockb .

RUN /root/.bun/bin/bun install --production

# ? -------------------------
FROM gcr.io/distroless/base

WORKDIR /splitter-plaid-bun

COPY --from=builder /root/.bun/bin/bun bun
COPY --from=builder /splitter-plaid-bun/node_modules node_modules

COPY src src
# COPY public public
# COPY tsconfig.json .

ENV ENV production
EXPOSE 8080
CMD ["./bun", "src/index.ts"]



FROM node:10-alpine

WORKDIR /app

RUN apk update && apk add --no-cache python g++ make openssh git bash curl openssl-dev
RUN export PYTHONPATH=${PYTHONPATH}:/usr/lib/python2.7

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH /root/.cargo/bin:$PATH
RUN rustup update

COPY ./scripts ./scripts
COPY ./packages ./packages
COPY ./backend ./backend
COPY ./package.json ./yarn.lock ./tsconfig.json ./

RUN RUSTFLAGS="-C target-feature=-crt-static" cargo build --release --manifest-path=./backend/Cargo.toml

RUN yarn 

EXPOSE 3000 8080

CMD ./target/release/telemetry
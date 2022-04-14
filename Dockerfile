FROM alpine:latest as os

ARG APP_VER=1.0.0
ARG APP_NAME=golang-boilerplate

# set environment
ENV APP_VER=$APP_VER
ENV APP_NAME=$APP_NAME
ENV ENV APP_PORT=3000

# create builder
FROM golang:1.14-alpine AS builder

# create directory
RUN mkdir -p /src

# set directory
WORKDIR /src

# copy file ke source
COPY ./src .

# Install Dependency
RUN go mod tidy
RUN go mod download

# build aplikasi
RUN go build -o api api.go

FROM scratch

#WORKDIR /dist

# Copies the binary from the builder
COPY --from=builder /src/api ./

# port yang digunakan
EXPOSE $APP_PORT

# jalankan aplikasi
CMD ["./api"]


FROM golang:1.22.0-alpine AS builder

RUN apk add --no-cache git gcc musl-dev

WORKDIR /final-sprint11

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o app

FROM alpine:latest

COPY --from=builder /final-sprint11/app /final-sprint11/app
COPY --from=builder /final-sprint11/tracker.db /final-sprint11/tracker.db
WORKDIR /final-sprint11
ENTRYPOINT ["./app"]
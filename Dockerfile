FROM golang:1.13 AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 go build -o app.bin -ldflags="-X 'main.version=${VERSION}'"

FROM alpine:3.14

ENV DEMO_APP_ADDR=:8080
ENV DEMO_REDIS_ADDR=redis:6379

COPY --from=builder /app/app.bin /app/app

EXPOSE 8080

CMD ["/app/app"]

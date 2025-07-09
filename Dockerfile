# ---------- STAGE 1: Build ----------
FROM golang:1.21 as builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .
RUN go build -o weather-appdd

# ---------- STAGE 2: Run ----------
FROM alpine:latest

RUN adduser -D appuser
WORKDIR /app

COPY --from=builder /app/weather-app .

USER appuser
ENTRYPOINT ["./weather-app"]

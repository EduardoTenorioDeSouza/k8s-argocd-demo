FROM golang:alpine AS build-stage

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY main.go ./

RUN go build -ldflags '-s -w' main.go

FROM scratch

WORKDIR /

COPY --from=build-stage /app /

EXPOSE 9090

ENTRYPOINT ["/main"]

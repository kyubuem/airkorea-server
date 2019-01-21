FROM golang:alpine AS build-env

RUN apk add --no-cache git

WORKDIR /go/src/github.com/kyubuem/airkorea-server

ENV GO111MODULE=on
COPY go.mod .
COPY go.sum .

RUN go mod download

RUN apk del git

FROM build-env AS server-builder

RUN apk add --no-cache alpine-sdk

COPY . .
RUN CGO_ENABLED=1 go install -a -ldflags "-w -extldflags -s"

RUN apk del alpine-sdk

FROM alpine AS airkorea-server
COPY --from=server-builder /go/bin/airkorea-server /bin/airkorea-server

EXPOSE 9090

ENV PORT 9090
ENV KEY "known"

ENTRYPOINT ["/bin/airkorea-server"]

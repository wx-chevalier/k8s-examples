FROM golang:1.12-alpine AS build 
ENV GO111MODULE on
ENV CGO_ENABLED 0
ENV GOOS linux

RUN apk add git make openssl

WORKDIR /go/src/wx.dev
ADD . .
RUN make test
RUN make app

FROM alpine
RUN apk --no-cache add ca-certificates && mkdir -p /app
WORKDIR /app
COPY --from=build /go/src/wx.dev/mutateme .
COPY --from=build /go/src/wx.dev/ssl ssl
CMD ["/app/mutateme"]

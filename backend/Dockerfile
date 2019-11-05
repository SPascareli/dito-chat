FROM golang:1.10

WORKDIR /go/src/app
COPY . .

RUN go get ./...
RUN go install -v ./...

CMD ["./backend"]

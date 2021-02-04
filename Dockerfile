FROM golang:1.10-alpine AS build
COPY . /go/src/github.com/joshisa/resource-labeler-operator/
WORKDIR /go/src/github.com/joshisa/resource-labeler-operator/
RUN go build -o /bin/resource-labeler-operator .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=build /bin/resource-labeler-operator /bin/resource-labeler-operator
ENTRYPOINT ["/bin/resource-labeler-operator"]

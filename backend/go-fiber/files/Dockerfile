FROM golang:1.27-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o server .

FROM alpine:3.24
WORKDIR /app
COPY --from=build /app/server .
EXPOSE 3000
CMD ["./server"]

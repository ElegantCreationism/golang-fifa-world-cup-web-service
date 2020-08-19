FROM golang:1.14-alpine AS builder

ENV CGO_ENABLED 0

WORKDIR /app
COPY . ./

# Using go mod.
# RUN go mod download
# Build the binary
RUN GOOS=linux GOARCH=amd64 go build -a -o ./bin/svc -ldflags="-s -w"

FROM scratch

# Copy our static executable
COPY --from=builder /app/bin/svc /svc

# Port on which the service will be exposed.
EXPOSE 8000

# Run the svc binary.
CMD ["./svc"]


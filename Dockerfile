FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y curl && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

RUN curl -sSL https://mcp.apollo.dev/download/nix/v0.3.0 | sh

# Copy the graphql directory containing schema and operations
COPY ./graphql /app/graphql

# Copy the entrypoint script
COPY ./entrypoint /app/entrypoint
RUN chmod +x /app/entrypoint

# Use the entrypoint script
ENTRYPOINT ["/app/entrypoint"]

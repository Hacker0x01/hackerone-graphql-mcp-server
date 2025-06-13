# HackerOne GraphQL MCP Server Docker Image

A Docker image that provides access to HackerOne's GraphQL API through the Model Context Protocol (MCP). Supports stdio transport only.

**Multi-Architecture Support**: This image supports both Intel/AMD (amd64) and Apple Silicon (arm64) architectures.

## Quick Start

1. **Run with an MCP client**:
   ```sh
   docker run -i --rm \
     -e ENDPOINT="https://hackerone.com/graphql" \
     -e TOKEN="<your_base64_encoded_token>" \
     hackertwo/hackerone-graphql-mcp-server:latest
   ```

## Environment Variables

- `ENDPOINT`: GraphQL endpoint URL (default: https://hackerone.com/graphql)
- `TOKEN`: Base64 encoded API token in format: `base64(username:api_key)`

## Generating an API Token

1. Visit https://hackerone.com/settings/api_token/edit to generate an API key
2. Encode as: `echo -n "username:api_key" | base64`
3. Use the resulting string as your TOKEN value

## Example config in editor (Zed)
```json
{
  "context_servers": {
    "hackerone-graphql-mcp-server": {
      "command": {
        "path": "/usr/local/bin/docker",
        "args": [
          "run",
          "-i",
          "--rm",
          "-e",
          "ENDPOINT=https://hackerone.com/graphql",
          "-e",
          "TOKEN=<your_base64_encoded_token>",
          "hackertwo/hackerone-graphql-mcp-server:latest"
        ]
      },
      "settings": {}
    }
  }
}
```

## Notes

- The Docker container is designed to be piped into an MCP-compatible client
- Running the container directly will result in an error as it expects an MCP client connection
- The `-i` flag is required to maintain standard input for the stdio transport
- The `schema.graphql` in this repository may become outdated over time, you can download the latest one from HackerOne at [https://hackerone.com/schema.graphql](https://hackerone.com/schema.graphql)

## Building Multi-Architecture Image

```
docker buildx create --name multiarch --driver docker-container --use
docker buildx inspect --bootstrap

# Build and push multi-arch image
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --tag hackertwo/hackerone-graphql-mcp-server:latest \
  --tag hackertwo/hackerone-graphql-mcp-server:v1.0.1 \
  --push \
  .
```

# HackerOne GraphQL MCP Server Docker Image

A Docker image that provides access to HackerOne's GraphQL API through the Model Context Protocol (MCP).

**Supported MCP transport types**: Currently only stdio transport is supported. Please file an issue if you require [other transports](https://modelcontextprotocol.io/docs/concepts/transports#built-in-transport-types).

**Multi-Architecture Support**: This image supports both Intel/AMD (amd64) and Apple Silicon (arm64) architectures.

## Quick Start

1. **Run with an MCP client**:
   ```sh
   docker run -i --rm \
     -e ENDPOINT="https://hackerone.com/graphql" \
     -e TOKEN="<your_base64_encoded_token>" \
     -e ALLOW_MUTATIONS="none" \
     hackertwo/hackerone-graphql-mcp-server:latest
   ```

## Docker Image Tags

- **`latest`**: Latest stable release (only updated on version releases)
- **`dev-<commit>`**: Development builds from main branch (e.g., `dev-abc1234`)
- **`v1.0.0`**: Specific version releases
- **`pr-<ref>`**: Pull request builds

## Environment Variables

- `ENDPOINT`: GraphQL endpoint URL (default: https://hackerone.com/graphql)
- `TOKEN`: Base64 encoded API token in format: `base64(username:api_key)`
- `ALLOW_MUTATIONS`: Controls which mutations are allowed (default: none)
  - `none`: No mutations allowed
  - `explicit`: Only explicitly defined mutations allowed
  - `all`: All mutations allowed

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
          "-e",
          "ALLOW_MUTATIONS=none",
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

## Development

### Creating a Release

To create a new release:

1. Create a [new release in GitHub](https://github.com/Hacker0x01/hackerone-graphql-mcp-server/releases/new)

2. GitHub Actions will automatically:
   - Build multi-architecture images (amd64, arm64)
   - Push to Docker Hub with appropriate tags
   - Update the `latest` tag

### Manual Build (Local Development)

For local development and testing:

```sh
# Setup buildx
docker buildx create --name multiarch --driver docker-container --use
docker buildx inspect --bootstrap

# Build and push the image
bin/build

# Clean up
docker buildx rm multiarch
```

### Updating the GraphQL schema

```sh
curl https://hackerone.com/schema.graphql -o graphql/schema.graphql
```

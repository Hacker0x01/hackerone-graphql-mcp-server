# HackerOne GraphQL MCP Server

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
     hackertwo/hackerone-graphql-mcp-server:1.0.5
   ```

## Docker Image Tags

- **`latest`**: Latest stable release (only updated on version releases)
- **`dev-main`**: Development builds from main branch
- **`1.x.x`**: Specific version releases
- **`pr-<ref>`**: Pull request builds

## Environment Variables

- `ENDPOINT`: GraphQL endpoint URL (default: https://hackerone.com/graphql)
- `TOKEN`: Base64 encoded API token in format: `base64(username:api_key)`
- `ALLOW_MUTATIONS`: Controls which mutations are allowed (default: none)
  - `none`: No mutations allowed
  - `explicit`: Only explicitly defined mutations allowed
  - `all`: All mutations allowed

## Generating an API Token

### Option 1: Using the included script (recommended)
1. Visit https://hackerone.com/settings/api_token/edit to generate an API key
2. Run the token generation script: `./scripts/generate_token.sh`
   This will prompt for your username and API key, then automatically encode and copy the token to your clipboard.
3. Use the resulting string as your TOKEN value

### Option 2: Manual encoding
1. Visit https://hackerone.com/settings/api_token/edit to generate an API key
2. Encode as: `echo -n "username:api_key" | base64`
3. Use the resulting string as your TOKEN value

## Example config in Flowise

1. Go to an Agent node
2. Go to tools
3. Select custom MCP
4. Put the following in the MCP parameters:

```json
{
    "command": "/usr/local/bin/docker",
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
        "hackertwo/hackerone-graphql-mcp-server:1.0.5"
    ]
}
```

## Example config in editor (Zed)

```json
{
  "context_servers": {
    "hackerone-graphql-mcp-server": {
      "source": "custom",
      "command": "/usr/local/bin/docker",
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
        "hackertwo/hackerone-graphql-mcp-server:1.0.5"
      ]
    }
  }
}
```

## Notes

- The Docker container is designed to be piped into an MCP-compatible client
- Running the container directly will result in an error as it expects an MCP client connection
- The `-i` flag is required to maintain standard input for the stdio transport
- The `schema.graphql` in this repository may become outdated over time, you can download the latest one from HackerOne at [https://hackerone.com/schema.graphql](https://hackerone.com/schema.graphql)

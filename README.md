# HackerOne GraphQL MCP Server

A Docker image that provides access to HackerOne's GraphQL API through the Model Context Protocol (MCP).

**Supported MCP transport types**: Currently only stdio transport is supported. Please file an issue if you require [other transports](https://modelcontextprotocol.io/docs/concepts/transports#built-in-transport-types).

**Multi-Architecture Support**: This image supports both Intel/AMD (amd64) and Apple Silicon (arm64) architectures.

**Built on Apollo MCP Server**: This project is a thin wrapper around the upstream [Apollo MCP Server](https://github.com/apollographql/apollo-mcp-server), which exposes GraphQL operations as MCP tools.

## Quick Start

1. **Run with an MCP client**:
   ```sh
   docker run -i --rm \
     -e ENDPOINT="https://hackerone.com/graphql" \
     -e TOKEN="<your_base64_encoded_token>" \
     -e MUTATION_MODE="none" \
     hackertwo/hackerone-graphql-mcp-server:1.0.6
   ```

## Docker Image Tags

- **`latest`**: Latest stable release (only updated on version releases)
- **`dev-main`**: Development builds from main branch
- **`1.x.x`**: Specific version releases
- **`pr-<ref>`**: Pull request builds

## Environment Variables

| Variable                     | Description                                                                                                                                                             | Default                         |
| ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------- |
| `ENDPOINT`                   | GraphQL endpoint URL                                                                                                                                                    | `https://hackerone.com/graphql` |
| `TOKEN`                      | Base64 encoded API token in format: `base64(username:api_key)`                                                                                                          | -                               |
| `MUTATION_MODE`              | Controls which mutations are allowed:<br/>• `none`: No mutations allowed<br/>• `explicit`: Only explicitly defined mutations allowed<br/>• `all`: All mutations allowed | `none`                          |
| `DISABLE_TYPE_DESCRIPTION`   | If set to `true`, tools will have no type descriptions (e.g. "The returned value has type ...")                                                                         | `false`                         |
| `DISABLE_SCHEMA_DESCRIPTION` | If set to `true`, tools will have no schema description                                                                                                                 | `false`                         |

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
        "MUTATION_MODE=none",
        "hackertwo/hackerone-graphql-mcp-server:1.0.6"
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
        "MUTATION_MODE=none",
        "hackertwo/hackerone-graphql-mcp-server:1.0.6"
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

## Issues & Contributions

- **HackerOne-specific behavior, configuration, token handling, schema quirks, mutation allow-listing, etc.:** open an issue in this repository.
- **Generic MCP behavior, transports, protocol details, or GraphQL tool exposure mechanics:** consider checking/filing upstream in **apollographql/apollo-mcp-server**.

## Licensing Notes

This project depends on [Apollo MCP Server](https://github.com/apollographql/apollo-mcp-server), which is licensed under the **MIT License**.  
Your use of this image includes use of Apollo MCP Server under its license; please review the upstream LICENSE.

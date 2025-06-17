# Changelog

## [1.0.3] - 2025-06-17

- Add `ALLOW_MUTATIONS` environment variable to control mutation permissions (default: none)
  - Supports values: `none`, `explicit`, `all`
  - Replaces hardcoded `--allow-mutations all` behavior

## [1.0.2] - 2025-06-13

- Fix invalid input schema for `GetHackerOneCurrentUser` tool (workaround for https://github.com/apollographql/apollo-mcp-server/issues/136)

## [1.0.1] - 2025-06-13

- Forward container arguments to the MCP server

## [1.0.0] - 2025-06-13

Initial release of HackerOne GraphQL MCP Server Docker image

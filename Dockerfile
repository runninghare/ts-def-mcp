# Generated by https://smithery.ai. See: https://smithery.ai/docs/config#dockerfile
FROM node:lts-alpine

# Install dependencies including bash for Bun installer
RUN apk add --no-cache bash curl git

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash

# Set PATH for bun binaries
ENV PATH="/root/.bun/bin:$PATH"

# Create app directory
WORKDIR /app

# Copy dependency and configuration files
COPY package.json bun.lock tsconfig.json ./

# Copy source files and other project files
COPY src ./src
COPY smithery.yaml ./
COPY README.md ./

# Install Node.js dependencies using Bun
RUN bun install

# Build the project using Bun
RUN bun run build

# By default this MCP server is launched via stdio, so we use the node command
CMD ["node", "dist/run.js"]

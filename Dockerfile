FROM docker.io/library/node:22.13.0-bookworm-slim AS base

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    bash \
    vim \
    tmux \
    htop \
    curl \
    wget \
    telnet \
    dumb-init

ENV NODE_ENV="production" \
    NITRO_PRESET="node_server"

FROM base AS build

RUN corepack enable pnpm
RUN corepack use pnpm@latest

COPY package.json pnpm-lock.yaml .npmrc ./
RUN pnpm install --frozen-lockfile

COPY . .
RUN pnpm run build

FROM base

RUN rm -rf /var/lib/apt/lists /var/cache/apt/archives
COPY --from=build /app/.output /app/.output

ENTRYPOINT ["/usr/bin/dumb-init", "--", "node", "/app/.output/server/index.mjs"]

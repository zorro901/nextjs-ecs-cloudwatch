FROM oven/bun:1-slim AS builder
WORKDIR /app

COPY package.json bun.lockb* ./
RUN bun install --frozen-lockfile --ignore-scripts

COPY . .

RUN bun next telemetry disable
RUN bun run build

# 本番用イメージ
FROM oven/bun:1-distroless AS runner
WORKDIR /app

ENV NODE_ENV production
ENV PORT 3000
ENV HOSTNAME "0.0.0.0"

COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/static ./.next/static

EXPOSE 3000

CMD ["server.js"]
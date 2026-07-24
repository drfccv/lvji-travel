FROM node:24-alpine
WORKDIR /app
RUN corepack enable
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm build
EXPOSE 4173

CMD ["sh", "-c", "npx drizzle-kit push && exec pnpm start"]

# ===== 构建阶段 =====
FROM node:24-alpine AS builder
WORKDIR /app
RUN corepack enable

# 依赖层 — 利用 Docker 缓存，package.json 不变时跳过
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN pnpm install --frozen-lockfile

# 源码层
COPY . .
RUN pnpm build

# ===== 运行阶段 =====
FROM node:24-alpine AS runner
WORKDIR /app
RUN corepack enable

# 只安装生产依赖 + drizzle-kit（运行时 push 需要）
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN pnpm install --frozen-lockfile --prod && \
    pnpm add -D drizzle-kit && \
    pnpm store prune

# 从构建阶段复制产物（源码不进入最终镜像）
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/db ./db
COPY --from=builder /app/drizzle.config.ts ./

EXPOSE 4173

CMD ["sh", "-c", "npx drizzle-kit push && exec pnpm start"]

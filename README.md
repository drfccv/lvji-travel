<div align="center">
  <img src="https://raw.githubusercontent.com/drfccv/lvji-travel/drfccv/electron-local/desktop/assets/icon.svg" alt="旅迹图标" width="120" height="120" />
</div>

<div align="center">

# 旅迹 · AI 旅行规划工作台

<br/>

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Next.js](https://img.shields.io/badge/Next.js-16-000000?logo=next.js&logoColor=white)](https://nextjs.org)
[![React](https://img.shields.io/badge/React-19-61DAFB?logo=react&logoColor=black)](https://react.dev)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.9-3178C6?logo=typescript&logoColor=white)](https://www.typescriptlang.org)
[![Electron](https://img.shields.io/badge/Electron-43-47848F?logo=electron&logoColor=white)](https://www.electronjs.org)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind%20CSS-4-38BDF8?logo=tailwindcss&logoColor=white)](https://tailwindcss.com)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-4169E1?logo=postgresql&logoColor=white)](https://www.postgresql.org)
[![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)](https://www.docker.com)

[![在线 Demo](https://img.shields.io/badge/在线_Demo-GitHub_Pages-2ea44f)](https://drfccv.github.io/lvji-travel/)
[![GitHub Pages 部署](https://github.com/drfccv/lvji-travel/actions/workflows/deploy-pages.yml/badge.svg)](https://github.com/drfccv/lvji-travel/actions/workflows/deploy-pages.yml)
[![Docker 镜像构建](https://github.com/drfccv/lvji-travel/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/drfccv/lvji-travel/actions/workflows/docker-publish.yml)
[![Windows](https://img.shields.io/badge/Windows-0078D6?logo=windows&logoColor=white)](https://github.com/drfccv/lvji-travel/releases)
[![macOS](https://img.shields.io/badge/macOS-333333?logo=apple&logoColor=white)](https://github.com/drfccv/lvji-travel/releases)
[![Linux](https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=black)](https://github.com/drfccv/lvji-travel/releases)

</div>

一个以 AI 对话驱动的旅行规划 Web 应用。旅迹将目的地、日期、预算和偏好转化为可编辑的逐日行程，并通过地图、天气以及 MCP 外部服务补充真实旅行信息。

**在线Demo：** [https://drfccv.github.io/lvji-travel/](https://drfccv.github.io/lvji-travel/)

![旅迹首页截图](https://www.liuyuan.top/usr/uploads/2026/08/4078085558.png)

## 功能特性

- **AI 行程规划**：根据目的地、日期、人数、预算和旅行偏好生成或调整方案。
- **逐日行程管理**：管理景点、交通、住宿、用餐、时间和费用等安排。
- **对话式修改**：识别确认、修订和取消意图，避免误写入尚未确认的方案。
- **地图与天气**：通过内置 MCP 工具获取地点、公交路线与天气信息，为行程提供出行参考。
- **MCP 工具扩展**：内置高德、Tavily、RollingGo 道旅等 MCP 服务预设，支持自定义地址与密钥，也可接入 12306、SearXNG 等自建服务。
- **上下文压缩（可选）**：通过 [Headroom](https://github.com/headroomlabs-ai/headroom) 代理自动压缩 AI 对话上下文，节省 10-35% Token。
- **版本与冲突保护**：提供版本快照、乐观并发、幂等操作和锁定安排保护。
- **日历导出**：将包含日期和时间的行程导出为日历事件。
- **用户数据隔离**：所有服务端读写都根据可信用户身份校验数据归属。
- **桌面客户端**：基于 Electron 43，内置 SQLite，无需数据库即可本地运行。

## 技术栈

- **前端框架**：Next.js 16（App Router）、React 19、TypeScript 5.9
- **桌面端**：Electron 43、better-sqlite3
- **样式与界面**：Tailwind CSS 4、Lucide React、React Markdown
- **服务端与数据**：Node.js 22、PostgreSQL 18、Drizzle ORM
- **AI 与外部服务**：OpenAI-compatible API、MCP（Streamable HTTP，内置高德 / Tavily / RollingGo 道旅预设，可接入 12306、SearXNG 等自建服务）、[Headroom](https://github.com/headroomlabs-ai/headroom) 上下文压缩
- **校验与工程化**：Zod 4、ESLint 9、Node.js Test Runner
- **部署**：Docker、Docker Compose

## 快速开始

### 一、本地运行（桌面客户端）

> 基于 Electron 43 构建，内置 SQLite，无需 PostgreSQL 即可本地运行，配置在 `drfccv/electron-local` 分支。

前往 [Releases 页面](https://github.com/drfccv/lvji-travel/releases) 下载对应系统的安装包：

| 平台 | 安装包 |
|------|--------|
| Windows | `lvji-*-win-x64.exe`（安装版）或 `lvji-*-win-x64-portable.exe`（便携版） |
| Linux | `lvji-*-linux-x86_64.AppImage` 或 `lvji-*-linux-amd64.deb` |
| macOS (Intel) | `lvji-*-mac-x64.dmg` |
| macOS (Apple Silicon) | `lvji-*-mac-arm64.dmg` |

下载安装后首次启动会打开配置页面，填入 AI 和 MCP 密钥即可使用，无需额外搭建数据库。

### 二、Docker 部署

> 适合服务器部署，需安装 Docker 和 Docker Compose。镜像由 GitHub Actions 在每次推送代码到 `main` 时自动构建并推送至 GitHub Container Registry。

#### 1. 首次安装

```bash
# 下载编排文件和环境变量模板
curl -fsSL \
  -O https://raw.githubusercontent.com/drfccv/lvji-travel/main/docker-compose.yml \
  -O https://raw.githubusercontent.com/drfccv/lvji-travel/main/.env.example
cp .env.example .env
```

生成随机数据库凭据和加密密钥（按操作系统选择）：

<details>
<summary><b>Linux / macOS</b>（自带 openssl + sed，推荐）</summary>

```bash
sed -i "s/^DB_USER=$/DB_USER=$(openssl rand -hex 4)/" .env
sed -i "s/^DB_PASS=$/DB_PASS=$(openssl rand -hex 12)/" .env
sed -i "s/^APP_ENCRYPTION_KEY=$/APP_ENCRYPTION_KEY=$(openssl rand -base64 32)/" .env
```

</details>

<details>
<summary><b>Windows</b>（PowerShell）</summary>

在 PowerShell 终端中逐行执行：

```powershell
$dbUser = -join ((48..57)+(97..102) | Get-Random -Count 8 | ForEach-Object { [char]$_ })
$dbPass = -join ((48..57)+(97..102) | Get-Random -Count 24 | ForEach-Object { [char]$_ })
$encKey = [Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Max 256 }))
(Get-Content .env) -replace "^DB_USER=$", "DB_USER=$dbUser" | Set-Content .env
(Get-Content .env) -replace "^DB_PASS=$", "DB_PASS=$dbPass" | Set-Content .env
(Get-Content .env) -replace "^APP_ENCRYPTION_KEY=$", "APP_ENCRYPTION_KEY=$encKey" | Set-Content .env
```

或用文本编辑器手动编辑 `.env` 中的 `DB_USER`、`DB_PASS`、`APP_ENCRYPTION_KEY` 为随机值。

</details>

#### 2. 启动服务

部署分为**标准模式**和**Headroom 模式**两种，前者不含上下文压缩，后者额外启用 Headroom 代理以节省 AI Token。

**标准模式（不含 Headroom）：**

```bash
docker compose up -d
```

**Headroom 模式（启用上下文压缩）：**

<details>
<summary><b>Linux / macOS</b></summary>

```bash
sed -i "s|^HEADROOM_PROXY=$|HEADROOM_PROXY=http://headroom:8787/v1|" .env
docker compose --profile headroom up -d
```

</details>

<details>
<summary><b>Windows</b></summary>

```powershell
(Get-Content .env) -replace "^HEADROOM_PROXY=$", "HEADROOM_PROXY=http://headroom:8787/v1" | Set-Content .env
docker compose --profile headroom up -d
```

</details>

启动后访问 <http://127.0.0.1:4173>（可通过 `.env` 中的 `APP_PORT` 更改宿主机端口）。

#### 3. 更新

**更新编排文件到最新：**

```bash
docker compose down
curl -fsSL \
  -O https://raw.githubusercontent.com/drfccv/lvji-travel/main/docker-compose.yml \
  -O https://raw.githubusercontent.com/drfccv/lvji-travel/main/.env.example
docker compose up -d
```

**更新服务镜像到最新：**

```bash
docker compose down
docker compose pull
docker compose up -d
```

## 环境变量

大部分配置（AI、MCP 密钥等）可在应用后台「设置」面板填写并持久化到数据库，无需环境变量。以下仅列出需要关注的：

| 变量 | 用途 |
| --- | --- |
| `DATABASE_URL` | PostgreSQL 连接字符串，如 `postgresql://user:password@127.0.0.1:5432/lvji` |
| `APP_ENCRYPTION_KEY` | AES-GCM 加密密钥，用于加密 AI/MCP 凭证；部署后请勿更改 |
| `AI_BASE_URL` / `AI_API_KEY` / `AI_MODEL` | AI 提供商兜底配置（可选） |
| `HEADROOM_PROXY` | Headroom 上下文压缩代理地址，如 `http://headroom:8787/v1`（可选） |
| `UAPI_API_KEY` | 天气服务 Key（可选） |

> 其余变量（`AMAP_WEB_SERVICE_KEY`、`TAVILY_API_KEY`、`MCP_12306_URL`、`MCP_SEARXNG_URL` 等）均可在后台「设置」中配置，完整清单见 `.env.example`。

## PostgreSQL

生产环境使用 PostgreSQL，保存用户、行程、安排、MCP 配置等数据。Docker 部署已内置 PostgreSQL 18，无需单独搭建。

## 推荐的开源 MCP 服务

以下开源 MCP 服务可选用，通过 `MCP_12306_URL`、`MCP_SEARXNG_URL` 或后台「设置」接入：

| 服务 | 说明 | 项目 |
| --- | --- | --- |
| 12306 MCP | 官方 12306 实时数据（余票、车站、经停、中转换乘） | [drfccv/mcp-server-12306](https://github.com/drfccv/mcp-server-12306) |
| SearXNG MCP | 私有网页搜索，支持任意 MCP 客户端 | [ihor-sokoliuk/mcp-searxng](https://github.com/ihor-sokoliuk/mcp-searxng) |

## 致谢

本项目使用了以下开源项目，特此致谢：

| 项目 | 用途 | 许可证 |
| --- | --- | --- |
| [Headroom](https://github.com/headroomlabs-ai/headroom) | AI 对话上下文压缩代理（可选） | Apache 2.0 |
| [Next.js](https://github.com/vercel/next.js) | 前端框架 | MIT |
| [Electron](https://github.com/electron/electron) | 桌面客户端 | MIT |
| [PostgreSQL](https://www.postgresql.org/) | 数据库 | PostgreSQL License |
| [Drizzle ORM](https://github.com/drizzle-team/drizzle-orm) | 数据库访问 | Apache 2.0 |
| [Tailwind CSS](https://github.com/tailwindlabs/tailwindcss) | 样式框架 | MIT |

> 内置 MCP 预设（高德、Tavily、RollingGo 道旅）为**商业服务**，凭证由使用者自行申请；12306、SearXNG 为可选接入的开源服务，见[推荐的开源 MCP 服务](#推荐的开源-mcp-服务)。

更多依赖详见各项目声明文件。

# Stage 1: Build
FROM node:18-alpine AS builder
WORKDIR /app

RUN npm install -g pnpm

COPY package*.json ./
RUN pnpm install

COPY . .
RUN pnpm run build

# Stage 2: Run
FROM node:18-alpine
WORKDIR /app

RUN npm install -g pnpm
COPY --from=builder /app/dist ./dist
COPY package*.json ./

RUN pnpm install --production

EXPOSE 3000
CMD ["pnpm", "run", "serve"]

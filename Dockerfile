FROM node:18-alpine as deps

RUN mkdir -p /seminario-jfal
WORKDIR /seminario-jfal
COPY package*.json ./
RUN npm ci

FROM node:18-alpine as builder
WORKDIR /seminario-jfal
COPY --from=deps /seminario-jfal/node_modules ./node_modules
COPY . .
ENV NEXT_TELEMETRY_DISABLED 1
RUN npm run build

FROM node:18-alpine as runner
WORKDIR /seminario-jfal
ENV NEXT_TELEMETRY_DISABLED 1
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs
COPY --from=builder  /seminario-jfal/next.config.js ./

COPY --from=builder --chown=nextjs:nodejs /seminario-jfal/public ./public
COPY --from=builder --chown=nextjs:nodejs /seminario-jfal/package.json ./package.json

COPY --from=builder --chown=nextjs:nodejs /seminario-jfal/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /seminario-jfal/.next/static ./.next/static

USER nextjs
EXPOSE 3000

ENV PORT 3000

CMD ["node", "server.js"]
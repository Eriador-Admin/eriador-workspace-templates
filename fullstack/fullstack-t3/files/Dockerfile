FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
COPY .env.example .env
RUN npx prisma generate
RUN npm run build
EXPOSE 3000
ENV PORT=3000
CMD ["npm", "start"]

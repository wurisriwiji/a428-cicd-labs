# Gunakan Node.js sebagai base image
FROM node:16-buster-slim

# Set direktori kerja di dalam container
WORKDIR /app

# Copy semua file ke dalam container
COPY . .

# Install dependencies dan build React App
RUN npm install && npm run build

# Jalankan aplikasi React menggunakan Node.js
CMD ["npx", "serve", "-s", "build", "-l", "3000"]

# Ekspos port 3000
EXPOSE 3000

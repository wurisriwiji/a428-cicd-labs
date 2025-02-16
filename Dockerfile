# 🔹 Gunakan image Node.js sebagai base image
FROM node:16-alpine

# Buat direktori kerja di dalam container
WORKDIR /app

# Salin file package.json dan package-lock.json terlebih dahulu
COPY package.json package-lock.json ./

# Instal dependensi
RUN npm install

# Salin semua file proyek ke dalam container
COPY . .

# Buka port yang digunakan oleh aplikasi React
EXPOSE 3000

# Perintah untuk menjalankan aplikasi React
CMD ["npm", "start"]
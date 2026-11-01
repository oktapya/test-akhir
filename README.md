# Aplikasi Manajemen Data Siswa

## 1. Deskripsi Project

Aplikasi Manajemen Data Siswa merupakan aplikasi yang dibuat untuk mempermudah pengelolaan data siswa. Aplikasi ini dikembangkan menggunakan Flutter sebagai frontend, Next.js sebagai backend, dan MySQL sebagai database.

Aplikasi ini dibuat sebagai project akhir mata pelajaran Rekayasa Perangkat Lunak (RPL).

## 2. Teknologi yang Digunakan

- **Flutter dan Dart:** digunakan untuk membuat tampilan dan fitur aplikasi.
- **Next.js dan TypeScript:** digunakan untuk membangun backend dan API.
- **Laragon:** digunakan sebagai lingkungan server lokal untuk menjalankan database.
- **MySQL:** digunakan sebagai sistem database untuk menyimpan data admin dan siswa.
- *Postman:* digunakan untuk menguji API dan memastikan setiap endpoint berjalan dengan baik.
- **Visual Studio Code:** digunakan untuk mengedit dan mengelola kode program.
- **Android Studio:** digunakan untuk menjalankan dan menguji aplikasi Flutter.

## 3. Fitur Aplikasi

- Login admin.
- Menampilkan data siswa.
- Menambahkan data siswa.
- Mengedit data siswa.
- Menghapus data siswa.

## 4. Struktur Folder Project

```text
test-akhir/
│
├── android/
├── lib/
│   └── server/
├── backend/
│   ├── app/
│   │   └── api/
│   │       ├── login/
│   │       └── siswa/
│   ├── lib/
│   └── package.json
│
├── database/
│   └── db_siswa2.sql
│
├── dokumentasi/
├── pubspec.yaml
└── README.md
```

## 5. Database

Project ini menggunakan database bernama `db_siswa2` yang memiliki dua tabel utama:

### Tabel admin
Digunakan untuk menyimpan data akun admin.

Kolom:
- id
- email
- password

### Tabel siswa
Digunakan untuk menyimpan data siswa.

Kolom:
- id
- nipd
- nama_lengkap
- jenis_kelamin
- alamat
- kelas
- jurusan

## 6. Cara Menjalankan Project

### A. Persiapan Database

1. Install dan buka aplikasi Laragon.
2. Klik **Start All** untuk menjalankan layanan yang diperlukan.
3. Buka pengelolaan database yang tersedia melalui Laragon.
4. Buat database dengan nama `db_siswa2`.
5. Import file `database/db_siswa2.sql` ke dalam database tersebut.
6. Pastikan tabel `admin` dan `siswa` sudah berhasil dibuat.

### B. Menjalankan Backend

1. Buka folder project melalui Visual Studio Code.
2. Buka terminal dan masuk ke folder backend:

   ```bash
   cd backend
   ```

3. Install dependencies:

   ```bash
   npm install
   ```

4. Jalankan backend:

   ```bash
   npm run dev
   ```

5. Backend berjalan pada alamat:

   ```text
   http://localhost:3000
   ```

### C. Menjalankan Aplikasi Flutter

1. Buka terminal baru pada folder utama project.
2. Jalankan perintah:

   ```bash
   flutter pub get
   ```

3. Hubungkan perangkat Android atau pilih emulator.
4. Jalankan aplikasi:

   ```bash
   flutter run
   ```

Pastikan Laragon dan backend sudah berjalan sebelum menggunakan aplikasi agar data siswa dapat ditampilkan.

## 7. API yang Digunakan

Backend menyediakan beberapa endpoint untuk mengelola data siswa dan login admin:

| Method | Endpoint | Fungsi |
|---|---|---|
| GET | `/api/siswa` | Menampilkan data siswa |
| POST | `/api/siswa` | Menambahkan data siswa |
| PUT | `/api/siswa` | Mengubah data siswa |
| DELETE | `/api/siswa` | Menghapus data siswa |
| POST | `/api/login` | Login admin |

## 8. Dokumentasi

Dokumentasi aplikasi berupa tangkapan layar tampilan aplikasi dapat dilihat pada folder `dokumentasi`.

## 9. Pengembang

Project ini dibuat sebagai tugas akhir mata pelajaran Rekayasa Perangkat Lunak (RPL) dengan tujuan menerapkan materi pengembangan aplikasi, pengelolaan database, dan pembuatan API.

import { NextResponse } from 'next/server';
import db from '@/lib/db';

// Pengaturan CORS
const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
};

// Fungsi untuk mengirim respons JSON dengan CORS
function response(data: any, status = 200) {
  return NextResponse.json(data, {
    status,
    headers: corsHeaders,
  });
}

// OPTIONS: Mengizinkan permintaan dari Flutter Web
export async function OPTIONS() {
  return new Response(null, {
    status: 204,
    headers: corsHeaders,
  });
}

// GET: Mengambil semua data siswa
export async function GET() {
  try {
    const [rows] = await db.query('SELECT * FROM siswa');

    return response({
      status: true,
      data: rows,
    });
  } catch (error) {
    console.error('ERROR GET:', error);

    return response({
      status: false,
      message: 'Gagal mengambil data siswa',
    }, 500);
  }
}

// POST: Menambahkan data siswa
export async function POST(request: Request) {
  try {
    const body = await request.json();

    const {
      nipd, nama_lengkap, jenis_kelamin,
      alamat, kelas, jurusan
    } = body;

    if (!nipd || !nama_lengkap || !jenis_kelamin ||
        !alamat || !kelas || !jurusan) {
      return response({
        status: false,
        message: 'Semua data harus diisi',
      }, 400);
    }

    await db.query(
      `INSERT INTO siswa
      (nipd, nama_lengkap, jenis_kelamin, alamat, kelas, jurusan)
      VALUES (?, ?, ?, ?, ?, ?)`,
      [nipd, nama_lengkap, jenis_kelamin, alamat, kelas, jurusan]
    );

    return response({
      status: true,
      message: 'Data siswa berhasil ditambahkan',
    });
  } catch (error) {
    console.error('ERROR POST:', error);

    return response({
      status: false,
      message: 'Gagal menambahkan data siswa',
    }, 500);
  }
}

// PUT: Mengubah data siswa
export async function PUT(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const id = searchParams.get('id');
    const body = await request.json();

    const {
      nipd, nama_lengkap, jenis_kelamin,
      alamat, kelas, jurusan
    } = body;

    if (!id) {
      return response({
        status: false,
        message: 'ID siswa harus diisi',
      }, 400);
    }

    if (!nipd || !nama_lengkap || !jenis_kelamin ||
        !alamat || !kelas || !jurusan) {
      return response({
        status: false,
        message: 'Semua data harus diisi',
      }, 400);
    }

    const [result]: any = await db.query(
      `UPDATE siswa SET
      nipd = ?, nama_lengkap = ?, jenis_kelamin = ?,
      alamat = ?, kelas = ?, jurusan = ?
      WHERE id = ?`,
      [nipd, nama_lengkap, jenis_kelamin, alamat, kelas, jurusan, id]
    );

    if (result.affectedRows === 0) {
      return response({
        status: false,
        message: 'Data siswa tidak ditemukan',
      }, 404);
    }

    return response({
      status: true,
      message: 'Data siswa berhasil diubah',
    });
  } catch (error) {
    console.error('ERROR PUT:', error);

    return response({
      status: false,
      message: 'Gagal mengubah data siswa',
    }, 500);
  }
}

// DELETE: Menghapus data siswa
export async function DELETE(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const id = searchParams.get('id');

    if (!id) {
      return response({
        status: false,
        message: 'ID siswa harus diisi',
      }, 400);
    }

    const [result]: any = await db.query(
      'DELETE FROM siswa WHERE id = ?',
      [id]
    );

    if (result.affectedRows === 0) {
      return response({
        status: false,
        message: 'Data siswa tidak ditemukan',
      }, 404);
    }

    return response({
      status: true,
      message: 'Data siswa berhasil dihapus',
    });
  } catch (error) {
    console.error('ERROR DELETE:', error);

    return response({
      status: false,
      message: 'Gagal menghapus data siswa',
    }, 500);
  }
}


import { NextResponse } from 'next/server';
import db from '@/lib/db';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization',
};

export async function OPTIONS() {
  return new Response(null, {
    status: 204,
    headers: corsHeaders,
  });
}

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { email, password } = body;

    if (!email || !password) {
      return NextResponse.json(
        {
          status: false,
          message: 'Email dan password harus diisi',
        },
        { status: 400, headers: corsHeaders }
      );
    }

    const [rows]: any = await db.execute(
      'SELECT * FROM admin WHERE email = ? AND password = ?',
      [email, password]
    );

    if (rows.length === 0) {
      return NextResponse.json(
        {
          status: false,
          message: 'Email atau password salah',
        },
        { status: 401, headers: corsHeaders }
      );
    }

    return NextResponse.json(
      {
        status: true,
        message: 'Login berhasil',
        data: {
          id: rows[0].id,
          email: rows[0].email,
        },
      },
      { status: 200, headers: corsHeaders }
    );

  } catch (error) {
    console.error('ERROR LOGIN:', error);

    return NextResponse.json(
      {
        status: false,
        message: 'Terjadi kesalahan pada server',
      },
      { status: 500, headers: corsHeaders }
    );
  }
}

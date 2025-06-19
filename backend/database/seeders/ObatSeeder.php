<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Obat;

class ObatSeeder extends Seeder
{
    public function run(): void
    {
        Obat::create([
            'nama' => 'Paracetamol',
            'harga' => 10000,
            'stok' => 50,
            'foto' => 'paracetamol.jpg',
            'deskripsi' => 'Obat penurun panas'
        ]);

        Obat::create([
            'nama' => 'Amoxicillin',
            'harga' => 15000,
            'stok' => 30,
            'foto' => 'amoxicillin.jpg',
            'deskripsi' => 'Antibiotik untuk infeksi'
        ]);

        Obat::create([
            'nama' => 'Salep Kulit',
            'harga' => 12500,
            'stok' => 40,
            'foto' => 'salep.jpg',
            'deskripsi' => 'Obat untuk kulit'
        ]);
    }
}

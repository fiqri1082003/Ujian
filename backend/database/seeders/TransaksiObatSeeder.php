<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TransaksiObatSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('transaksi_obat')->insert([
            ['transaksi_transaksi_id' => 1, 'obat_obat_id' => 1, 'jumlah' => 2],
            ['transaksi_transaksi_id' => 1, 'obat_obat_id' => 2, 'jumlah' => 1],
            ['transaksi_transaksi_id' => 2, 'obat_obat_id' => 3, 'jumlah' => 3],
        ]);
    }
}

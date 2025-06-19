<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Transaksi;

class TransaksiSeeder extends Seeder
{
    public function run(): void
    {
        Transaksi::create([
            'user_id' => 1,
            'status' => 'pending',
        ]);

        Transaksi::create([
            'user_id' => 2,
            'status' => 'finish',
        ]);

        Transaksi::create([
            'user_id' => 3,
            'status' => 'pending',
        ]);
    }
}

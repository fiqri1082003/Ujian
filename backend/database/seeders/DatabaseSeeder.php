<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Panggil semua seeder satu per satu
        $this->call([
            UserSeeder::class,
            ObatSeeder::class,
            TransaksiSeeder::class,
            TransaksiObatSeeder::class,
        ]);
    }
}

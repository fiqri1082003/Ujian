<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        User::create([
            'username' => 'Fatih',
            'email' => 'fatih@gmail.com',
            'password' => Hash::make('password'),
            'alamat' => 'Depok',
            'role' => 'admin',
            'foto' => 'foto/fatih.jpg',
        ]);

        User::create([
            'username' => 'Haikal',
            'email' => 'haikal@gmail.com',
            'password' => Hash::make('password'),
            'alamat' => 'Jakarta',
            'role' => 'user',
            'foto' => 'foto/haikal.jpg',
        ]);

        User::create([
            'username' => 'Amirullah',
            'email' => 'amirullah@gmail.com',
            'password' => Hash::make('password'),
            'alamat' => 'Bogor',
            'role' => 'user',
            'foto' => 'foto/amirullah.jpg',
        ]);
    }
}

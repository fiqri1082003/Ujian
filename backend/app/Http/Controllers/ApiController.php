<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Obat;
use App\Models\Transaksi;

class ApiController extends Controller
{
    public function getUsers()
    {
        return User::all();
    }

    public function getObats()
    {
        return Obat::all();
    }

    public function getTransaksis()
    {
        return Transaksi::with(['user', 'obats'])->get();
    }
}

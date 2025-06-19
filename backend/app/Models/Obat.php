<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Obat extends Model
{
    protected $fillable = [
        'nama',
        'harga',
        'stok',
        'foto',
        'deskripsi',
    ];

    protected $primaryKey = 'obat_id';

    public function transaksis()
    {
        return $this->belongsToMany(Transaksi::class, 'transaksi_obat', 'obat_obat_id', 'transaksi_transaksi_id')->withPivot('jumlah');
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Transaksi extends Model
{
    protected $fillable = ['user_id'];

    protected $primaryKey = 'transaksi_id';

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function obats()
    {
        return $this->belongsToMany(Obat::class, 'transaksi_obat', 'transaksi_transaksi_id', 'obat_obat_id')->withPivot('jumlah');
    }
}

<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('transaksi_obat', function (Blueprint $table) {
            $table->unsignedBigInteger('transaksi_transaksi_id');
            $table->unsignedBigInteger('obat_obat_id');
            $table->integer('jumlah')->default(1); // Tambahan kolom jumlah

            // Composite primary key (opsional tapi umum untuk pivot)
            $table->primary(['transaksi_transaksi_id', 'obat_obat_id']);

            // Foreign keys
            $table->foreign('transaksi_transaksi_id')
                  ->references('transaksi_id')->on('transaksis')->onDelete('cascade');
            $table->foreign('obat_obat_id')
                  ->references('obat_id')->on('obats')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('transaksi_obat');
    }
};

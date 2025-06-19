<?php

namespace App\Http\Controllers;

use App\Models\Transaksi;
use Illuminate\Http\Request;

class TransaksiController extends Controller
{
    public function index()
    {
        return response()->json([
            'status' => 'success',
            'message' => 'Data transaksi berhasil diambil',
            'data' => Transaksi::with(['user', 'obats'])->get()
        ], 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,user_id',
            'obats' => 'required|array',
            'obats.*.id' => 'required|exists:obats,obat_id',
            'obats.*.jumlah' => 'required|integer|min:1'
        ]);

        $transaksi = Transaksi::create([
            'user_id' => $validated['user_id'],
        ]);

        $pivotData = [];
        foreach ($validated['obats'] as $obat) {
            $pivotData[$obat['id']] = ['jumlah' => $obat['jumlah']];
        }

        $transaksi->obats()->attach($pivotData);

        return response()->json([
            'status' => 'success',
            'message' => 'Transaksi berhasil dibuat',
            'data' => $transaksi->load('user', 'obats')
        ], 201);
    }

    public function show($id)
    {
        $transaksi = Transaksi::with(['user', 'obats'])->findOrFail($id);

        return response()->json([
            'status' => 'success',
            'message' => 'Detail transaksi berhasil ditemukan',
            'data' => $transaksi
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $transaksi = Transaksi::findOrFail($id);

        if ($request->has('user_id')) {
            $transaksi->user_id = $request->user_id;
            $transaksi->save();
        }

        if ($request->has('obat_id')) {
            $transaksi->obats()->sync($request->obat_id);
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Transaksi berhasil diperbarui',
            'data' => $transaksi->load('user', 'obats')
        ], 200);
    }

    public function destroy($id)
    {
        $transaksi = Transaksi::findOrFail($id);
        $transaksi->obats()->detach();
        $transaksi->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Transaksi berhasil dihapus'
        ], 200);
    }
}

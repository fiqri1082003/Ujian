<?php

namespace App\Http\Controllers;

use App\Models\Obat;
use Illuminate\Http\Request;

class ObatController extends Controller
{
    public function index()
    {
        return response()->json([
            'status' => 'success',
            'message' => 'Data obat berhasil diambil',
            'data' => Obat::all()
        ], 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'nama' => 'required|string',
            'harga' => 'required|numeric',
            'stok' => 'required|integer',
            'foto' => 'nullable|string',
            'deskripsi' => 'required|string',
        ]);

        $obat = Obat::create($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Data obat berhasil ditambahkan',
            'data' => $obat
        ], 201);
    }

    public function show($id)
    {
        $obat = Obat::findOrFail($id);

        return response()->json([
            'status' => 'success',
            'message' => 'Data obat berhasil ditemukan',
            'data' => $obat
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'nama' => 'required|string',
            'harga' => 'required|numeric',
            'stok' => 'required|integer',
            'foto' => 'nullable|string',
            'deskripsi' => 'required|string',
        ]);

        $obat = Obat::findOrFail($id);
        $obat->update($validated);

        return response()->json([
            'status' => 'success',
            'message' => 'Data obat berhasil diperbarui',
            'data' => $obat
        ], 200);
    }

    public function destroy($id)
    {
        $obat = Obat::findOrFail($id);
        $obat->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Data obat berhasil dihapus'
        ], 200);
    }
}

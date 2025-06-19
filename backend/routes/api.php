<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ObatController;
use App\Http\Controllers\TransaksiController;
use App\Models\User;

// Routes GET (akses publik)
Route::get('/obats', [ObatController::class, 'index']);
Route::get('/obats/{id}', [ObatController::class, 'show']);

// Register (user baru)
Route::post('/register', [UserController::class, 'register']);


Route::post('/login', function (Request $request) {
    $user = User::where('email', $request->email)->first();

    if (!$user || !Hash::check($request->password, $user->password)) {
        return response()->json(['message' => 'Invalid credentials'], 401);
    }

    $token = $user->createToken('api-token')->plainTextToken;

    return response()->json([
        'access_token' => $token,
        'token_type' => 'Bearer',
        'user' => $user,
    ]);
})->name('login');


// Logout
Route::middleware('auth:sanctum')->post('/logout', function (Request $request) {
    $request->user()->currentAccessToken()->delete();
    return response()->json(['message' => 'Logged out']);
});

// Routes yang butuh login
Route::middleware('auth:sanctum')->group(function () {
    // Users
    Route::get('/users', [UserController::class, 'index']);
    Route::put('/users/{user_id}', [UserController::class, 'update']);
    Route::get('/users/{id}', [UserController::class, 'show']);
    Route::delete('/users/{user_id}', [UserController::class, 'destroy']);

    // Obats
    Route::post('/obats', [ObatController::class, 'store']);
    Route::put('/obats/{id}', [ObatController::class, 'update']);
    Route::delete('/obats/{id}', [ObatController::class, 'destroy']);

    // Transaksis
    Route::get('/transaksis', [TransaksiController::class, 'index']);
    Route::get('/transaksis/{id}', [TransaksiController::class, 'show']);
    Route::post('/transaksis', [TransaksiController::class, 'store']);
    Route::put('/transaksis/{id}', [TransaksiController::class, 'update']);
    Route::delete('/transaksis/{id}', [TransaksiController::class, 'destroy']);
});

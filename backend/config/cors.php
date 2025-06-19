<?php

return [

    /*
    |----------------------------------------------------------------------
    | Cross-Origin Resource Sharing (CORS) Configuration
    |----------------------------------------------------------------------
    |
    | Here you may configure your settings for cross-origin resource sharing
    | or "CORS". This determines what cross-origin operations may execute
    | in web browsers. You are free to adjust these settings as needed.
    |
    | To learn more: https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
    |
    */

    'paths' => ['api/*', 'sanctum/csrf-cookie'], // Paths yang perlu diakses oleh frontend

    'allowed_methods' => ['GET', 'POST', 'PUT', 'DELETE'], // Sesuaikan dengan metode yang digunakan

    'allowed_origins' => [
        'http://127.0.0.1:3000',  // URL aplikasi Flutter saat dikembangkan di localhost
        'http://localhost:3000',   // Alternatif jika menggunakan localhost sebagai alamat
        // tambahkan domain frontend lainnya jika ada
    ],

    'allowed_origins_patterns' => [],

    'allowed_headers' => [
        'Content-Type',
        'X-Requested-With',
        'Authorization',
        'Accept',
        'X-CSRF-TOKEN', // jika menggunakan CSRF untuk Sanctum
    ],

    'exposed_headers' => [],

    'max_age' => 0,

    'supports_credentials' => true,  // Sangat penting jika menggunakan Sanctum

];

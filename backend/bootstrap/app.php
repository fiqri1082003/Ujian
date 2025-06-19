<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Auth\AuthenticationException;
use Symfony\Component\HttpFoundation\Response;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__ . '/../routes/web.php',
        commands: __DIR__ . '/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        //
    })
    ->withExceptions(function (Exceptions $exceptions) {
        $exceptions->render(function (\Illuminate\Auth\AuthenticationException $e, $request) {
            // Gunakan $e agar tidak ada warning Intelephense
            logger()->warning('Unauthorized access attempt: ' . $e->getMessage());

            return response()->json([
                'message' => 'Kamu tidak memiliki akses. Silakan login terlebih dahulu.'
            ], \Symfony\Component\HttpFoundation\Response::HTTP_UNAUTHORIZED);
        });
    })
    ->create();

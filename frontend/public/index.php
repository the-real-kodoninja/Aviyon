<?php

use App\Kernel;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\BinaryFileResponse;

set_time_limit(60);
ini_set('max_execution_time', 60);

// Load the Symfony runtime
require_once dirname(__DIR__) . '/vendor/autoload_runtime.php';

// Bootstrap the kernel using the runtime
$kernelFactory = function (array $context) {
    return new Kernel($context['APP_ENV'], (bool) $context['APP_DEBUG']);
};

// Create the request
$request = Request::createFromGlobals();

// Serve static assets from /build/
$path = $request->getPathInfo();
if (preg_match('/^\/build\/(.*)$/', $path, $matches)) {
    $file = __DIR__ . '/build/' . $matches[1];
    if (file_exists($file)) {
        return new BinaryFileResponse($file);
    }
}

// If not a static asset, proceed with the Symfony kernel
$kernel = $kernelFactory(['APP_ENV' => 'dev', 'APP_DEBUG' => true]);
$response = $kernel->handle($request);
$response->send();
$kernel->terminate($request, $response);

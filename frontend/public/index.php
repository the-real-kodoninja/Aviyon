<?php
use App\Kernel;
set_time_limit(60);
ini_set('max_execution_time', 60);
require_once dirname(__DIR__).'/vendor/autoload_runtime.php';
return function (array $context) {
    return new Kernel($context['APP_ENV'], (bool) $context['APP_DEBUG']);
};

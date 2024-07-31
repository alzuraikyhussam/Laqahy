<?php

use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schedule;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote')->hourly();

// Schedule::command('app:send-reminder')->everyMinute();
Schedule::command('app:send-reminder')->dailyAt('09:00');
Schedule::command('app:delete-old-sanctum-tokens')->monthly();

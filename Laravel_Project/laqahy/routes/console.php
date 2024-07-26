<?php

use App\Console\Commands\SendReminder;
use Illuminate\Support\Facades\Schedule;
use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote')->hourly();

// Schedule::command('app:send-reminder')->everyMinute();
Schedule::command('app:send-reminder')->dailyAt('09:00');

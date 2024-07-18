<?php

use App\Console\Commands\SendReminder;
use Illuminate\Support\Facades\Schedule;
use Illuminate\Foundation\Inspiring;
use Illuminate\Support\Facades\Artisan;

Artisan::command('inspire', function () {
    $this->comment(Inspiring::quote());
})->purpose('Display an inspiring quote')->hourly();

// Schedule::command('job:dispatch-send-reminder-job')->everySecond();

Schedule::command('app:send-reminder')->everyMinute();
// Schedule::job(new SendReminder(new FcmService))->dailyAt('23:16');






// Schedule::command('job:dispatch-send-reminder-job')->everySecond();

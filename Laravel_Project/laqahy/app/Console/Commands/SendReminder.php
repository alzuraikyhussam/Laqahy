<?php

namespace App\Console\Commands;

use App\Models\Child_statement;
use App\Models\Mother_statement;
use App\Models\Notifications;
use App\Services\FcmService;
use Exception;
use Illuminate\Console\Command;
use Illuminate\Support\Str;

class SendReminder extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:send-reminder';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        try {

            $fcmService = new FcmService();

            $mothers = Mother_statement::join('mother_data', 'mother_statements.mother_data_id', '=', 'mother_data.id')->select('mother_statements.*', 'mother_data.mother_name', 'mother_data.fcm_token')->whereDate('mother_statements.return_date', now()->toDateString())->whereNotNull('mother_data.fcm_token')->get();

            $children = Child_statement::join('child_data', 'child_statements.child_data_id', '=', 'child_data.id')->join('mother_data', 'child_data.mother_data_id', '=', 'mother_data.id')->select('child_statements.*', 'child_data.child_data_name', 'child_data.mother_data_id', 'mother_data.mother_name', 'mother_data.fcm_token')->whereDate('child_statements.return_date', now()->toDateString())->whereNotNull('mother_data.fcm_token')->get();

            foreach ($mothers as $mother) {
                info("Cron Job mothers running at == " . now());

                $mother_name = Str::of($mother->mother_name)->words(2, '');


                $title = 'تذكير بموعد العودة';
                $body = 'عزيزتي ' . $mother_name . ' لقد حان موعد العودة لأخذ جرعة اللقاح الخاصة بك ';

                // Send notification
                $fcmService->sendNotification($mother->fcm_token, $title, $body);


                Notifications::create([
                    'mother_data_id' => $mother->id,
                    'notification_title' => $title,
                    'notification_description' => $body,
                ]);
            }

            foreach ($children as $child) {
                info("Cron Job children running at == " . now());

                $mother_name = Str::of($child->mother_name)->words(2, '');
                $child_name = Str::of($child->child_data_name)->words(2, '');


                $title = 'تذكير بموعد العودة';
                $body = 'عزيزتي ' . $mother_name . ' لقد حان موعد العودة لتطعيم طفلك ' . $child_name;

                // Send notification
                $fcmService->sendNotification($child->fcm_token, $title, $body);


                Notifications::create([
                    'mother_data_id' => $child->mother_data_id,
                    'notification_title' => $title,
                    'notification_description' => $body,
                ]);
            }
        } catch (Exception $e) {
        }
    }
}

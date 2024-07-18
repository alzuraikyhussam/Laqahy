<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

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
        info("Cron Job running at == " . now());

        // $fcmService = new FcmService();
        // Log::info('SendReminder job executed at: ' . now());


        // $mothers = Mother_statement::join('mother_data', 'mother_statements.mother_data_id', '=', 'mother_data.id')->select('mother_statements.*', 'mother_data.mother_name')->whereDate('mother_statements.return_date', now()->toDateString())->get();
        // $children = Child_statement::join('child_data', 'child_statements.child_data_id', '=', 'child_data.id')->select('child_statements.*', 'child_data.child_name')->whereDate('child_statements.return_date', now()->toDateString())->get();

        // foreach ($mothers as $mother) {

        //     if ($mother->fcm_token) {
        //         $title = 'تذكير بموعد العودة';
        //         $body = 'عزيزتي ' . $mother->mother_name . ' لقد حان موعد العودة لأخذ جرعة القاح الخاصة بك ';

        //         // Send notification
        //         $fcmService->sendNotification($mother->fcm_token, $title, $body);
        //     }
        // }

        // foreach ($children as $child) {

        //     if ($child->fcm_token) {
        //         $title = 'تذكير بموعد العودة';
        //         $body = 'عزيزتي ' . $mother->mother_name . ' لقد حان موعد تطعيم طفلك ' . $child->child_name;

        //         // Send notification
        //         $fcmService->sendNotification($child->fcm_token, $title, $body);
        //     }
        // }
    }
}

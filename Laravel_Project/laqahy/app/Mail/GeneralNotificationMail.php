<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class GeneralNotificationMail extends Mailable
{
    use Queueable, SerializesModels;

    public $recipientName;

    public function __construct($recipientName)
    {
        $this->recipientName = $recipientName;
    }

    public function build()
    {
        return $this->view('emails.general_notification')
            ->from(config('mail.from.address'), config('mail.from.name'))
            ->subject('تأكيد استلام طلب الدعم');
    }
}

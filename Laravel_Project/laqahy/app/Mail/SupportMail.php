<?php


namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SupportMail extends Mailable
{
    use Queueable, SerializesModels;

    public $data;

    public function __construct($data)
    {
        $this->data = $data;
    }

    public function build()
    {
        return $this->view('emails.support')
            ->from(config('mail.from.address'), config('mail.from.name'))
            ->replyTo($this->data['email'], $this->data['name'])
            ->subject('طلب دعم');
    }
}

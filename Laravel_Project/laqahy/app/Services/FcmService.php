<?php

// namespace App\Services;

// use GuzzleHttp\Client;
// use GuzzleHttp\Exception\RequestException;
// use Firebase\JWT\JWT;

// class FcmService
// {
//     protected $client;
//     protected $projectId;
//     protected $clientEmail;
//     protected $privateKey;

//     public function __construct()
//     {
//         $this->client = new Client([
//             'base_uri' => 'https://fcm.googleapis.com/v1/',
//             'headers' => [
//                 'Authorization' => 'Bearer ' . $this->getAccessToken(),
//                 'Content-Type' => 'application/json',
//             ],
//         ]);

//         $this->projectId = config('services.firebase.project_id');
//         $this->clientEmail = config('services.firebase.client_email');
//         $this->privateKey = str_replace('\n', "\n", config('services.firebase.private_key'));
//     }

//     protected function getAccessToken()
//     {
//         $client = new Client();
//         $response = $client->post('https://accounts.google.com/o/oauth2/token', [
//             'form_params' => [
//                 'grant_type' => 'urn:ietf:params:oauth:grant-type:jwt-bearer',
//                 'assertion' => $this->generateJwt(),
//             ],
//         ]);

//         $body = json_decode((string) $response->getBody(), true);
//         return $body['access_token'];
//     }

//     protected function generateJwt()
//     {
//         $now = time();
//         $payload = [
//             'iat' => $now,
//             'exp' => $now + 3600,
//             'aud' => 'https://accounts.google.com/o/oauth2/token',
//             'scope' => 'https://www.googleapis.com/auth/firebase.messaging',
//             'iss' => $this->clientEmail,
//         ];

//         return JWT::encode($payload, $this->privateKey, 'RS256');
//     }

//     public function sendNotification($deviceToken, $title, $body)
//     {
//         $message = [
//             'message' => [
//                 'token' => $deviceToken,
//                 'notification' => [
//                     'title' => $title,
//                     'body' => $body,
//                 ],
//             ],
//         ];

//         try {
//             $response = $this->client->post('projects/' . $this->projectId . '/messages:send', [
//                 'json' => $message,
//             ]);

//             return $response->getBody()->getContents();
//         } catch (RequestException $e) {
//             if ($e->hasResponse()) {
//                 return $e->getResponse()->getBody()->getContents();
//             } else {
//                 return 'Failed to send notification: ' . $e->getMessage();
//             }
//         }
//     }
// }

namespace App\Services;

use App\Models\Mother_data;
use Kreait\Firebase\Factory;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;
use App\Models\User; // تأكد من استيراد موديل المستخدم هنا

class FcmService
{
    protected $messaging;

    public function __construct()
    {
        $factory = (new Factory)
            ->withServiceAccount(__DIR__.'/firebase-adminsdk.json'); // تحديد مسار ملف الخدمة

        $this->messaging = $factory->createMessaging();
    }

    public function sendNotificationToAllUsers($title, $body)
    {
        $users = Mother_data::whereNotNull('fcm_token')->get(); // استرجاع جميع المستخدمين الذين لديهم توكن FCM

        foreach ($users as $user) {
            $this->sendNotification($user->fcm_token, $title, $body);
        }
    }

    public function sendNotification($deviceToken, $title, $body)
    {
        $message = CloudMessage::withTarget('token', $deviceToken)
            ->withNotification(Notification::create($title, $body));

        $this->messaging->send($message);
    }
}


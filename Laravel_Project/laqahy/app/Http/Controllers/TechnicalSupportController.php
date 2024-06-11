<?php

namespace App\Http\Controllers;

use App\Mail\GeneralNotificationMail;
use App\Mail\SupportMail;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;

class TechnicalSupportController extends Controller
{
    public function sendMessage(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'name' => 'required',
                'email' => 'required',
                'message' => 'required',
            ],);

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            $data = $request->only('name', 'email', 'message');

            // Send support message
            Mail::to('sourcetechno2022@gmail.com')->send(new SupportMail($data));

            // Send notification email
            Mail::to($data['email'])->send(new GeneralNotificationMail($data['name']));

            return response()->json(['message' => 'Support message sent and notification sent successfully!'], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}

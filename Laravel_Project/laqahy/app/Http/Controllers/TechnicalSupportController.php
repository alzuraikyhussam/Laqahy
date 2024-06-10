<?php

namespace App\Http\Controllers;

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

            $name = $request->name;
            $email = $request->email;
            $msg = $request->message;

            if ($validator->fails()) {
                return response()->json([
                    'message' => $validator->errors(),
                ], 400);
            }

            // Send mail
            Mail::raw($msg, function ($message) use ($email, $name) {
                $message->from(config('mail.from.address'), config('mail.from.name'))->to('sourcetechno2022@gmail.com')->subject('رسالة واردة من : ' . $name);
            });

            return response()->json([
                'message' => 'Transmitted successfully',
            ], 200);
        } catch (Exception $e) {
            return response()->json([
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}

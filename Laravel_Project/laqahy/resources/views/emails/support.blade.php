<!DOCTYPE html>
<html dir="rtl" lang="ar">

<head>
    <meta charset="utf-8">
    <title>لقاحي | Laqahy</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .content {
            line-height: 1.6;
        }

        .footer {
            margin-top: 20px;
            text-align: center;
            font-size: 0.9em;
            color: #666;
        }
    </style>
</head>

<body dir="rtl">
    <div class="container">
        <div class="header">
            <h1>طلب الدعم</h1>
        </div>
        <div class="content">
            <p>السلام عليكم،</p>
            <p>لقد تلقينا طلب دعم جديد بالتفاصيل التالية:</p>
            <p><strong>الاسم:</strong> {{ $data['name'] }}</p>
            <p><strong>البريد الإلكتروني:</strong> {{ $data['email'] }}</p>
            <p><strong>الرسالة:</strong></p>
            <p>{{ $data['message'] }}</p>
            <p>يرجى التعامل مع هذا الطلب في أقرب وقت ممكن.</p>
            <p>شكراً لكم.</p>
        </div>
        <div class="footer">
            <p>هذه رسالة آلية. يرجى عدم الرد على هذا البريد الإلكتروني مباشرة.</p>
        </div>
    </div>
</body>

</html>

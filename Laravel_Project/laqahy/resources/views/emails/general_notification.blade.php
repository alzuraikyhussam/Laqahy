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

        .header img {
            width: 600px;
            /* Adjust the size as needed */
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
            <img src="{{ asset('logo.png') }}" alt="App Logo">
            <h1>تأكيد استلام الطلب</h1>
        </div>
        <div class="content">
            <p>السيد/السيدة {{ $recipientName }},</p>
            <p>نود أن نعلمكم بأننا قد استلمنا طلب الدعم الخاص بكم، وسنعمل على معالجته في أقرب وقت ممكن.</p>
            <p>يرجى العلم بأننا نقدر تقديراً كبيراً لثقتكم بنا، ونحن هنا لمساعدتكم في حل أي مشكلة تواجهكم.</p>
            <p>شكراً لتواصلكم معنا ولتفهمكم.</p>
            <br />
            <p style="font-weight:bold;">أطيب التحيات،</p>
            <p>لقاحي | Laqahy</p>
        </div>
        <br />
        <div class="footer">
            <p>هذه الرسالة تم إرسالها آلياً، يرجى عدم الرد عليها.</p>
        </div>
    </div>
</body>

</html>

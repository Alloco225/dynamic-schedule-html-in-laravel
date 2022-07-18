<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="{{ mix('/js/app.js') }}"></script>
    <link rel="stylesheet" href="{{ url(mix('css/app.css')) }}">
    <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>
    <div id="vue-app-estimation">
        <app-estimate-component></app-estimate-component>
    </div>
</body>
</html>

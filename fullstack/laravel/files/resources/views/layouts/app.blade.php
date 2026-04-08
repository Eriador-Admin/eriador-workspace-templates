<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>@yield('title', config('app.name'))</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: system-ui, sans-serif; line-height: 1.6; color: #1e293b; }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 1rem; }
        header { background: #1e293b; color: #fff; padding: 1rem 0; }
        header a { color: #fff; text-decoration: none; }
        main { padding: 2rem 0; }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <a href="/">{{ config('app.name') }}</a>
        </div>
    </header>

    <main>
        <div class="container">
            @yield('content')
        </div>
    </main>
</body>
</html>

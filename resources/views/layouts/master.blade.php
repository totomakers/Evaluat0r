<html lang="en">
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('bower/bootstrap/dist/css/bootstrap.min.css'); !!}"/>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('bower/animate.css/animate.min.css'); !!}"/>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('bower/font-awesome/css/font-awesome.min.css'); !!}"/>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('custom/css/lumen.min.css'); !!}"/>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('custom/css/style.css'); !!}"/>
        <title>Evaluat0r - @yield('page_title')</title>
    </head>
    <body>
        <div class="container">
            @yield('content')
        </div>
    </body>
    @yield('riot_tag')
    <script type="text/javascript" src="{!! URL::asset('bower/jquery/dist/jquery.min.js'); !!}"></script>
    <script type="text/javascript" src="{!! URL::asset('bower/bootstrap/dist/js/bootstrap.min.js'); !!}"></script>
    <script type="text/javascript" src="{!! URL::asset('custom/js/riot_compiler.js'); !!}"></script>
    @yield('js_script')
</html>
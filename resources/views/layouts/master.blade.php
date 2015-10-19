<html>
    <head>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('bower/bootstrap/dist/css/bootstrap.min.css'); !!}"/>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('bower/bootstrap/dist/css/bootstrap-theme.min.css'); !!}"/>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('bower/animate.css/animate.min.css'); !!}"/>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('bower/font-awesome/css/font-awesome.min.css'); !!}"/>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('custom/lumen.min.css'); !!}"/>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('custom/style.css'); !!}"/>
        <title>Evaluat0r - @yield('page_title')</title>
    </head>
    <body>
        <div class="container">
            @yield('content')
        </div>
    </body>
    <script type="text/javascript" src="{!! URL::asset('bower/jquery/dist/jquery.min.js'); !!}"></script>
        <script type="text/javascript" src="{!! URL::asset('bower/bootstrap/dist/js/bootstrap.min.js'); !!}"></script>
</html>
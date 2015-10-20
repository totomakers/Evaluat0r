<html lang="en">
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('bower/bootstrap/dist/css/bootstrap.min.css'); !!}"/>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('bower/animate.css/animate.min.css'); !!}"/>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('bower/font-awesome/css/font-awesome.min.css'); !!}"/>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('custom/css/lumen.min.css'); !!}"/>
        <link rel="stylesheet" type="text/css" href="{!! URL::asset('custom/css/style.css'); !!}"/>
        @yield('css')
        <title>Evaluat0r - @yield('page_title')</title>
    </head>
     @yield('nav')
    <body>
        <div class="container" id="app_content">
           @yield('content')
        </div>
    </body>
    @yield('riot_tag')
    <script type="text/javascript" src="{!! URL::asset('bower/jquery/dist/jquery.min.js'); !!}"></script>
    <script type="text/javascript" src="{!! URL::asset('bower/bootstrap/dist/js/bootstrap.min.js'); !!}"></script>
    <script type="text/javascript" src="{!! URL::asset('custom/js/riot_compiler.js'); !!}"></script>
    <script>
        //-------------------------------
        //Handle message from policies --
        var self = this;
        var unvailable_server = "{!! Lang::get('server.unvailable') !!}";

        var message = "{!! Session::get('message') !!}";
        @if(Session::has('error'))
            var error = {!! Session::get('error') !!};
        @else
            var error;
        @endif
        //-------------------------------
    </script>
    @yield('js_script')
</html>
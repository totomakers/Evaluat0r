@extends('layouts.master')
@section('page_title', '')

@section('css')
<link rel="stylesheet" type="text/css" href="{!! URL::asset('custom/css/simple-sidebar.css'); !!}"/>
@endsection

@section('menu')
<appnav></appnav>
@endsection

@section('content')
<app></app>
@endsection

@section('riot_tag')
<script src="riot/app/menu.tag" type="riot/tag"></script>
<script src="riot/app/app.tag" type="riot/tag"></script>
@endsection

@section('js_script')
<script type="text/javascript" src="{!! URL::asset('custom/js/sidebar.js'); !!}"></script>
<script>

//-------------------------------
//Handle message from policies --
var unvailable_server = "{!! Lang::get('server.unvailable') !!}";


var message = "{!! Session::get('message') !!}";
@if(Session::has('error'))
    var error = {!! Session::get('error') !!};
@else
    var error;
@endif
//-------------------------------

riot.mount('appnav');
riot.mount('app');
</script>
@endsection
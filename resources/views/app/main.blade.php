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
<script src="riot/tags/menu.tag" type="riot/tag"></script>
<script src="riot/tags/app.tag" type="riot/tag"></script>
@endsection

@section('js_script')
<script type="text/javascript" src="{!! URL::asset('custom/js/sidebar.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/auth.js'); !!}"></script>
<script>
    riot.mount('appnav', auth);
    riot.mount('app');
</script>
@endsection
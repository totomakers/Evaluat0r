@extends('layouts.master')
@section('page_title', '')

@section('css')
<link rel="stylesheet" type="text/css" href="{!! URL::asset('custom/css/simple-sidebar.css'); !!}"/>
@endsection

@section('nav')
<app_nav></app_nav>
@endsection

@section('content')
<div class="center-block" id="app_loader">
    <span class="loader"><span class="loader-inner"></span></span>
</div>
@endsection

@section('riot_tag')
<script src="riot/tags/nav.tag" type="riot/tag"></script>
<!-- Add tag here for view-->
<script src="riot/tags/home.tag" type="riot/tag"></script>
<script src="riot/tags/themes.tag" type="riot/tag"></script>
<script src="riot/tags/modeles.tag" type="riot/tag"></script>
@endsection

@section('js_script')
<script type="text/javascript" src="{!! URL::asset('custom/js/sidebar.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('custom/js/global.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/api.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/router.js'); !!}"></script>
<script>
    riot.mount('app_nav', api);
</script>
@endsection
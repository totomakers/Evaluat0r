@extends('layouts.master')
@section('page_title', '')

@section('css')
<link rel="stylesheet" type="text/css" href="{!! URL::asset('custom/css/simple-sidebar.css'); !!}"/>
@endsection

@section('nav')
 <nav class="animated slideInLeft navbar navbar-inverse sidebar" role="navigation" active></nav>
@endsection

@section('content')
<div class="center-block" id="app_loader">
    <div class="spinner">
      <div class="bounce1"></div>
      <div class="bounce2"></div>
      <div class="bounce3"></div>
    </div>
</div>
@endsection

@section('riot_tag')
<script src="riot/tags/nav.tag" type="riot/tag"></script>
<!-- Add tag here for view-->
<script src="riot/tags/raw.tag" type="riot/tag"></script>
<script src="riot/tags/home.tag" type="riot/tag"></script>
<script src="riot/tags/themes.tag" type="riot/tag"></script>
<script src="riot/tags/themes_edit.tag" type="riot/tag"></script>
<script src="riot/tags/themes_questions.tag" type="riot/tag"></script>
<script src="riot/tags/themes_questions_add.tag" type="riot/tag"></script>
<script src="riot/tags/modeles.tag" type="riot/tag"></script>
<script src="riot/tags/modeles_themes.tag" type="riot/tag"></script>
@endsection

@section('js_script')
<script type="text/javascript" src="{!! URL::asset('custom/js/sidebar.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('custom/js/global.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/api.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/themes.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/questions.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/answers.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/router.js'); !!}"></script>
<script>
   riot.mount($('nav'), 'app_nav', api);
</script>
@endsection
@extends('layouts.master')
@section('page_title', '')

@section('css')
<link rel="stylesheet" type="text/css" href="{!! URL::asset('custom/css/simple-sidebar.css'); !!}"/>
<link rel="stylesheet" type="text/css" href="{!! URL::asset('bower/select2/dist/css/select2.min.css'); !!}"/>
<link rel="stylesheet" type="text/css" href="{!! URL::asset('bower/clockpicker/dist/bootstrap-clockpicker.min.css'); !!}"/>
<link rel="stylesheet" type="text/css" href="{!! URL::asset('bower/eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css'); !!}"/>
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
<script src="riot/tags/templates.tag" type="riot/tag"></script>
<script src="riot/tags/templates_themes.tag" type="riot/tag"></script>
<script src="riot/tags/sessions.tag" type="riot/tag"></script>
<script src="riot/tags/sessions_edit.tag" type="riot/tag"></script>
<script src="riot/tags/sessions_modify.tag" type="riot/tag"></script>
<script src="riot/tags/sessions_candidates.tag" type="riot/tag"></script>
<script src="riot/tags/sessions_questions.tag" type="riot/tag"></script>
@endsection

@section('js_script')
<script type="text/javascript" src="{!! URL::asset('bower/markdown/lib/markdown.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('bower/bootstrap-markdown/js/bootstrap-markdown.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('bower/clockpicker/dist/bootstrap-clockpicker.min.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('bower/twbs-pagination/jquery.twbsPagination.min.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('bower/he/he.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('bower/twbs-pagination/jquery.twbsPagination.min.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('bower/select2/dist/js/select2.full.min.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('bower/select2/dist/js/i18n/fr.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('bower/moment/min/moment-with-locales.min.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('bower/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('custom/js/sidebar.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('custom/js/global.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/auth.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/theme.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/template.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/question.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/answer.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/session.js'); !!}"></script>
<script type="text/javascript" src="{!! URL::asset('riot/app/router.js'); !!}"></script>
<script>
   riot.mount($('nav'), 'app_nav', auth);
</script>
@endsection
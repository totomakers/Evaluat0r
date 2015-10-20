@extends('layouts.master')
@section('page_title', 'Connexion')

@section('content')
<login></login>
@endsection

@section('riot_tag')
<script src="riot/tags/login.tag" type="riot/tag"></script>
@endsection

@section('js_script')
<script type="text/javascript" src="{!! URL::asset('riot/app/api.js'); !!}"></script>
<script>
riot.mount('login', api);
</script>
@endsection
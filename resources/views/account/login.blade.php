@extends('layouts.master')
@section('page_title', 'Connexion')

@section('content')
<login></login>
@endsection

@section('riot_tag')
<script src="riot/auth/login.tag" type="riot/tag"></script>
@endsection

@section('js_script')
<script>
riot.mount('login');
</script>
@endsection
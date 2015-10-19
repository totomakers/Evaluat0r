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

var message = "{{ Session::get('message') }}";

@if(Session::has('error'))
    var error = {{ Session::get('error') }};
@else
    var error;
@endif

console.log(message);

riot.mount('login');
</script>
@endsection
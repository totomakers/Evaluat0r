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

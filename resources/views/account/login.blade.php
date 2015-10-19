@extends('layouts.master')
@section('page_title', 'Connexion')

@section('content')

<div class="center-block">
    <div class="row text-center">
        <div class="col-lg-12">
            <h1>Connexion</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-4 col-lg-offset-4">
            <div class="panel panel-default">
              <div class="panel-body">
                <div class="text-center">
                    <img src="{!! URL::asset('custom/picture/user.png'); !!}" alt="" class="profil-picture img-circle">
                </div>
                <hr>
                <form>
                    <div class="form-group">
                        <label for="email">Adresse mail</label>
                        <input type="text" class="form-control" id="email" placeholder="mail@fai.com">
                    </div>
                    <div class="form-group">
                        <label for="password">Mot de passe</label>
                        <input type="password" class="form-control" id="password" placeholder="•••••••••">
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-success">Connexion</button>
                    </div>
                </form>
              </div>
            </div>
        </div>
    </div>
</div>

@endsection
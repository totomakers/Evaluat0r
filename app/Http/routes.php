<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/

/*
Route::get('/', function () {
    return view('welcome');
});
*/

Route::get('/', ['as' => 'appli::home', 'uses' => 'AccountController@vueLogin']);

Route::group(['as' => 'api', 'prefix' => 'api'], function () 
{
    //|-------------------
    //| Auth routes
    //|-------------------
    Route::group(['as' => '::accounts', 'prefix' => 'accounts'], function () 
    {
        Route::get('/', ['as' => '::getAll', 'uses'=>'AccountController@getAll']);
        Route::get('/{id}', ['as' => '::get', 'uses'=>'AccountController@getById'])->where('id', '[0-9]+');
        
        Route::get('/login', function(){});
        Route::post('/login', ['as' => '::login', 'uses'=>'AccountController@postLogin']);
    });
   
});
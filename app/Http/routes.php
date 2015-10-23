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

Route::get('/', ['as' => 'appli::login', 'uses' => 'AccountController@vueLogin']);

Route::get('/app', ['as' => 'appli::home', 'middleware' => 'auth.rank:0', 'uses'=>'AppController@home']);

Route::group(['as' => 'api', 'prefix' => 'api'], function () 
{
    //|-------------------
    //| Auth routes
    //|-------------------
    Route::group(['as' => '::accounts', 'prefix' => 'accounts'], function () 
    {
        Route::get('/', ['as' => '::getAll', 'middleware' => 'auth.rank:0', 'uses'=>'AccountController@getAll']);
        Route::get('/{id}', ['as' => '::get', 'uses'=>'AccountController@getById'])->where('id', '[0-9]+');
        Route::get('/profil', ['as' => '::profil', 'middleware' => 'auth.rank:0', 'uses'=>'AccountController@getProfil']);

        Route::post('/login', ['as' => '::login', 'uses'=>'AccountController@postLogin']);
        Route::get('/logout', ['as' => '::logout', 'uses'=>'AccountController@getLogout']);
    });
    
    //|-------------------
    //| Theme routes
    //|-------------------
    Route::group(['as' => '::themes', 'prefix' => 'themes'], function () 
    {
        Route::get('/', ['as' => '::getAll', 'middleware' => 'auth.rank:2', 'uses'=>'ThemeController@getAll']);
        Route::get('/{id}', ['as' => '::get', 'middleware' => 'auth.rank:2', 'uses'=>'ThemeController@getById']);
        Route::get('/{id}/questions', ['as' => '::getQuestionsByTheme', 'middleware' => 'auth.rank:0', 'uses'=>'ThemeController@getQuestionsByTheme']);
        
        Route::post('/add', ['as' => '::postAdd', 'middleware' => 'auth.rank:2', 'uses'=>'ThemeController@postAdd']);
        Route::delete('/delete/{id}', ['as' => '::deleteDelete', 'middleware' => 'auth.rank:2', 'uses'=>'ThemeController@deleteDelete'])->where('id', '[0-9]+');
    });
    
    //|-------------------
    //| Question routes
    //|-------------------
    Route::group(['as' => '::questions', 'prefix' => 'questions'], function () 
    {
        Route::get('/', ['as' => '::getAll', 'middleware' => 'auth.rank:2', 'uses'=>'QuestionController@getAll']);
        Route::post('/add', ['as' => '::postAdd', 'middleware' => 'auth.rank:2', 'uses'=>'QuestionController@postAdd']);
    });
    
    //|--------------------
    //| Registration routes
    //|--------------------
    Route::group(['as' => '::registrations', 'prefix' => 'registrations'], function () 
    {
        Route::get('/', ['as' => '::getAll', 'middleware' => 'auth.rank:1', 'uses'=>'RegistrationController@getAll']);
    });
   
});
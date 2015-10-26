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
        Route::get('/select2', ['as'=> '::select2', 'middleware' => 'auth.rank:2', 'uses'=>'ThemeController@getSelect2']);
       
        Route::get('/{id}', ['as' => '::get', 'middleware' => 'auth.rank:2', 'uses'=>'ThemeController@getById'])->where('id', '[0-9]+');
        Route::get('/{id}/questions', ['as' => '::getQuestionsByTheme', 'middleware' => 'auth.rank:0', 'uses'=>'ThemeController@getQuestionsByTheme'])->where('id', '[0-9]+');
        
        Route::post('/add', ['as' => '::postAdd', 'middleware' => 'auth.rank:2', 'uses'=>'ThemeController@postAdd']);
        Route::delete('/{id}', ['as' => '::deleteDelete', 'middleware' => 'auth.rank:2', 'uses'=>'ThemeController@deleteDelete'])->where('id', '[0-9]+');
    });
    
    //|-------------------
    //| Question routes
    //|-------------------
    Route::group(['as' => '::questions', 'prefix' => 'questions'], function () 
    {
        Route::get('/', ['as' => '::getAll', 'middleware' => 'auth.rank:2', 'uses'=>'QuestionController@getAll']);
        Route::post('/add', ['as' => '::postAdd', 'middleware' => 'auth.rank:2', 'uses'=>'QuestionController@postAdd']);
        Route::delete('/{id}', ['as' => '::deleteDelete', 'middleware' => 'auth.rank:2', 'uses'=>'QuestionController@deleteDelete'])->where('id', '[0-9]+');
    });
    
    //|--------------------
    //| Template routes
    //|--------------------
    Route::group(['as' => '::templates', 'prefix' => 'templates'], function () 
    {
        Route::get('/', ['as' => '::getAll', 'middleware' => 'auth.rank:2', 'uses'=>'TemplateController@getAll']);
        Route::get('/{id}/themes', ['as' => '::getThemesByTemplate', 'middleware' => 'auth.rank:2', 'uses'=>'TemplateController@getThemesByTemplate'])->where('id', '[0-9]+');
        Route::post('/{id}/themes/add', ['as' => '::postAddTheme', 'middleware' => 'auth.rank:2', 'uses'=>'TemplateController@postAddTheme'])->where('id', '[0-9]+');
        Route::delete('/{id}/themes/{id_theme}', ['as' => '::deleteRemoveTheme', 'middleware' => 'auth.rank:2', 'uses'=>'TemplateController@deleteRemoveTheme'])->where('id', '[0-9]+')->where('id_theme', '[0-9]+');
        
        
        Route::delete('/{id}', ['as' => '::deleteDelete', 'middleware' => 'auth.rank:2', 'uses'=>'TemplateController@deleteDelete'])->where('id', '[0-9]+');
        Route::post('/add', ['as' => '::postAdd', 'middleware' => 'auth.rank:2', 'uses'=>'TemplateController@postAdd']);
    });
    
    //|--------------------
    //| Session routes
    //|--------------------
    Route::group(['as' => '::sessions', 'prefix' => 'sessions'], function () 
    {
        Route::get('/', ['as' => '::getAll', 'middleware' => 'auth.rank:1', 'uses'=>'SessionController@getAll']);
    });
    

});
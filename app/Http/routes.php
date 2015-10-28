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
        Route::get('/',                     ['as' => '::getAll', 'middleware' => 'auth.rank:0', 'uses'=>'AccountController@getAll']);
        Route::get('/{id}',                 ['as' => '::get', 'uses'=>'AccountController@getById'])->where('id', '[0-9]+');
        Route::get('/profil',               ['as' => '::profil', 'middleware' => 'auth.rank:0', 'uses'=>'AccountController@getProfil']);
        Route::post('/login',               ['as' => '::login', 'uses'=>'AccountController@postLogin']);
        Route::get('/logout',               ['as' => '::logout', 'uses'=>'AccountController@getLogout']);
        
        //select2
        Route::get('/select2/candidates',   ['as' => '::select2::candidate', 'uses'=>'AccountController@getSelect2Candidates']);
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
        Route::delete('/{id}/themes/{theme_id}', ['as' => '::deleteRemoveTheme', 'middleware' => 'auth.rank:2', 'uses'=>'TemplateController@deleteRemoveTheme'])->where('id', '[0-9]+')->where('id_theme', '[0-9]+');
        Route::delete('/{id}', ['as' => '::deleteDelete', 'middleware' => 'auth.rank:2', 'uses'=>'TemplateController@deleteDelete'])->where('id', '[0-9]+');
        Route::post('/add', ['as' => '::postAdd', 'middleware' => 'auth.rank:2', 'uses'=>'TemplateController@postAdd']);
        Route::get('/select2', ['as' => '::select2', 'middleware' => 'auth.rank:1', 'uses'=>'TemplateController@getSelect2']);
    });
    
    //|--------------------
    //| Session routes
    //|--------------------
    Route::group(['as' => '::sessions', 'prefix' => 'sessions'], function () 
    {
        Route::get('/', ['as' => '::getAll', 'middleware' => 'auth.rank:1', 'uses'=>'SessionController@getAll']);
        Route::get('/{id}', ['as' => '::get', 'middleware' => 'auth.rank:0', 'uses'=>'SessionController@getById'])->where('id', '[0-9]+');
        Route::delete('/{id}', ['as' => '::deleteDelete', 'middleware' => 'auth.rank:1', 'uses'=>'SessionController@deleteDelete'])->where('id', '[0-9]+');
        Route::put('/{id}', ['as' => '::put',  'middleware' => 'auth.rank:1', 'uses'=>'SessionController@putUpdate'])->where('id', '[0-9]+');
        Route::post('/add', ['as' => '::postAdd', 'middleware' => 'auth.rank:1', 'uses'=>'SessionController@postAdd']);
        Route::get('/{id}/questions/', ['as' => '::getQuestions', 'middleware' => 'auth.rank:1', 'uses'=>'SessionController@getQuestions'])->where('id', '[0-9]+');
        Route::put('/{id}/questions/from/{theme_id}', ['as' => '::putGenerateQuestion', 'middleware' => 'auth.rank:1', 'uses'=>'SessionController@putGenerateQuestion'])->where('id', '[0-9]+');
        Route::get('/{id}/candidates', ['as' => '::getCandidates', 'middleware' => 'auth.rank:1', 'uses'=>'SessionController@getCandidates'])->where('id', '[0-9]+');
        Route::delete('/{id}/candidates/{account_id}', ['as' => '::deleteRemoveCandidate', 'middleware' => 'auth.rank:1', 'uses'=>'SessionController@deleteRemoveCandidate'])->where('id', '[0-9]+');
        Route::post('/{id}/candidates/add', ['as' => '::postAddCandidate', 'middleware' => 'auth.rank:1', 'uses'=>'SessionController@postAddCandidate'])->where('id', '[0-9]+');
   });
    
    //|--------------------
    //| Evaluation routes
    //|--------------------
    Route::group(['as' => '::evaluations', 'prefix' => 'evaluations'], function () 
    {
        Route::get('/', ['as' => '::getAll', 'middleware' => 'auth.rank:0', 'uses'=>'EvaluationController@getCurrentEvaluation']);
        Route::get('/start/{session_id}', ['as' => '::start', 'middleware' => 'auth.rank:0', 'uses'=>'EvaluationController@getStart']);
    });
    

});
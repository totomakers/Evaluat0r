<?php

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Lang;

use Auth;
use App\Http\Controllers\Controller;
use App\Models\Account;

class AppController extends Controller
{
    public function __construct()
    {
    }
    
    public function home()
    {
        return view('app.main');
    }
}

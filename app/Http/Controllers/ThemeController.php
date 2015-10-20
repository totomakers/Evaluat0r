<?php

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Lang;

use Auth;
use App\Http\Controllers\Controller;
use App\Models\Theme;

class ThemeController extends Controller
{
    public function __construct()
    {
    }
    
     /**
     * getAll() return all Theme in database
     * @return jsonArray return a json array with all accounts
     */
    public function getAll()
    {
        try
        {
            $themes = Theme::all();
            return response()->json(["error"=> false, "message" =>"", "data" => $themes]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
}

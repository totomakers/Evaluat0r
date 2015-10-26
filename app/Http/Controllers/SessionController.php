<?php

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Lang;

use Auth;
use App\Http\Controllers\Controller;
use App\Models\Session;


class SessionController extends Controller
{
    public function __construct()
    {
    }

     /**
     * @api {get} /session Request Registrations information
     * @apiName getAll
     * @apiGroup Questions
     *
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data Data of all questions
     */
    public function getAll()
    {
        try
        {
            $registrations = Session::all();
            return response()->json(["error"=> false, "message" =>"", "data" => $questions]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
}

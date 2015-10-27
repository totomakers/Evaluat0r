<?php

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Lang;

use Auth;
use App\Http\Controllers\Controller;
use App\Models\Evaluation;

class EvaluationController extends Controller
{
    public function __construct()
    {
    }
        
    //----------------------------
    //API ------------------------
    //----------------------------
    
     /**
     * @api {get} /evaluations Request Themes information
     * @apiName getAll
     * @apiGroup Themes
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data all themes
     */
    public function getAll()
    {
        try
        {
            $evaluations = Evaluations::all();
            return response()->json(["error"=> false, "message" =>"", "data" => $accounts]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
}

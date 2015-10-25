<?php

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Lang;

use Auth;
use App\Http\Controllers\Controller;
use App\Models\Template;

class TemplateController extends Controller
{
    public function __construct()
    {
    }
        
    //----------------------------
    //API ------------------------
    //----------------------------
    
     /**
     * @api {get} /templates Request Templates information
     * @apiName getAll
     * @apiGroup Templates
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data all templates
     */
    public function getAll(Request $request)
    {
        try
        {
            $templates = Template::orderBy('name');
            
            if($request->has('page'))
            {
                 $page = $request->input('page');
                 $results = $templates->paginate(8);
                 
                 if($results->lastPage() < $page)
                 {
                    $templates->replace(array('page' => $results->lastPage())); //change the page
                    $templates = $templates->paginate(8);
                 }                 

                 return response()->json(["error"=> false, "message" =>"", "data" => $results->toArray()]);
            }
            
            $templates = Template::get();
            return response()->json(["error"=> false, "message" =>"", "data" => $templates]);

        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
}

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
                    $request->replace(array('page' => $results->lastPage())); //change the page
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
    
     /**
     * @api {get} /templates/{id}/themes Request Template Themes information
     * @apiName getThemesByTheme
     * @apiGroup Templates
     *
     * @apiParam {Number} id Template unique ID
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data all themes link to the themes
     */
    public function getThemesByTemplate($id)
    {
        try
        {
            $template = Template::with('themes')->find($id);

            if(!$template)
                return response()->json(["error" => true, "message" => Lang::get('template.notFound'), "data" => []]);
            
            return response()->json(["error" => true, "message" => "", "data" => $template->themes]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    /**
     * @api {post} /templates/add add a new template
     * @apiName Add
     * @apiGroup Templates
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data new template data
     */
    public function postAdd(Request $request)
    {
        try
        {
            //rules to apply of each field
            $rules = array(
                'name'          => 'required|min:2|max:25',
                'duration'      => 'required|date_format:G:i',
                'accepted_prc'  => 'required|numeric|min:0|max:100',
                'ongoing_prc'   => 'required|numeric|min:0|max:100',
            );
            
            $errorsJson = array();
            
            //try to validate
            $validator = Validator::make($request->all(), $rules);
            if ($validator->fails()) 
            {
                $errors = $validator->messages()->getMessages();
                
                //---------
                //name ----
                //---------
                if(array_key_exists("name", $errors))
                    for($j = 0; $j < count($errors["name"]); ++$j)
                    {
                        $key = $errors["name"][$j];
                        $value = (strpos($key, '.min.') !== false) ? 2 : 25; 
                        array_push($errorsJson, Lang::get('validator.'.$key, ["name" => "Nom", "value" => $value]));
                    }
                    
                //----------
                //duration -
                //----------
                if(array_key_exists("duration", $errors))
                    for($j = 0; $j < count($errors["duration"]); ++$j)
                    {
                        $key = $errors["duration"][$j];
                        array_push($errorsJson, Lang::get('validator.'.$key, ["name" => "Durée", "value" => ""]));
                    }
                    
                //--------------
                //accepted_prc -
                //--------------
                if(array_key_exists("accepted_prc", $errors))
                    for($j = 0; $j < count($errors["accepted_prc"]); ++$j)
                    {
                        $key = $errors["accepted_prc"][$j];
                        $value = (strpos($key, '.min.') !== false) ? 0 : 100; 
                        array_push($errorsJson, Lang::get('validator.'.$key, ["name" => "'% pour être admis'", "value" => $value]));
                    }
                    
                    
                //--------------
                //ongoing_prc -
                //--------------
                if(array_key_exists("ongoing_prc", $errors))
                    for($j = 0; $j < count($errors["ongoing_prc"]); ++$j)
                    {
                        $key = $errors["ongoing_prc"][$j];
                        $value = (strpos($key, '.min.') !== false) ? 0 : 100; 
                        array_push($errorsJson, Lang::get('validator.'.$key, ["name" => "'% pour être en cours d'acquisition'", "value" => $value]));
                    }

                //error
                return response()->json(["error" => true, "message" => $errorsJson, "data" => []]);
            }
            else //ok
            {
                if($request->accepted_prc <= $request->ongoing_prc)
                {
                    array_push($errorsJson, Lang::get('template.onGoingPrcBadValue'));
                    return response()->json(["error" => true, "message" => $errorsJson, "data" => []]);
                }
                
                $template = new template();
                $template->name = $request->name;
                $template->duration = $request->duration;
                $template->accepted_prc = $request->accepted_prc;
                $template->ongoing_prc = $request->ongoing_prc;
                $template->save();
                
                return response()->json(["error" => false, "message" => Lang::get('template.add', ["name" => $template->name]), "data" => $template]);
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
     /**
     * @api {delete} /templates/{id} delete a specific template
     * @apiName delete
     * @apiGroup Templates
     *
     * @apiParam {Number} id Template unique ID
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data current deleted template
     */
    public function deleteDelete($id)
    {
        try
        {
            $template = Template::find($id);
            
            if(!$template)
                return response()->json(["error" => true, "message" => Lang::get('template.notFound'), "data" => []]);
            else
            {
                $template->delete();
                return response()->json(["error" => true, "message" => Lang::get('template.delete', ['name' => $template->name]), "data" => $template]);
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
}

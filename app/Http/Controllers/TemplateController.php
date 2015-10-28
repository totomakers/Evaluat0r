<?php

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Lang;

use Auth;
use App\Http\Controllers\Controller;
use App\Models\Template;
use App\Models\Theme;

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
            
            return response()->json(["error" => false, "message" => "", "data" => ["data" => $template->themes, "from" => $id]]);
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
                return response()->json(["error" => false, "message" => Lang::get('template.delete', ['name' => $template->name]), "data" => $template]);
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    /**
     * @api {post} /templates/{id}/themes/add link a themes with a templates
     * @apiName themes add
     * @apiGroup Templates
     *
     * @apiParam {Number} id Template unique ID
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data 
     */
    public function postAddTheme($id, Request $request)
    {
        try
        {
            //rules to apply of each field
            $rules = array(
                'theme_id'         => 'required|integer|exists:theme,id',
                'question_count'   => 'required|numeric|min:1',
            );
            
            $errorsJson = array();
            
            //try to validate
            $validator = Validator::make($request->all(), $rules);
            if ($validator->fails()) 
            {
                $errors = $validator->messages()->getMessages();
                
                //---------
                //theme_id ----
                //---------
                if(array_key_exists("theme_id", $errors))
                    for($j = 0; $j < count($errors["theme_id"]); ++$j)
                    {
                        $key = $errors["theme_id"][$j];
                        array_push($errorsJson, Lang::get('validator.'.$key, ["name" => "Theme"]));
                    }
                    
                //----------------
                //question_count -
                //----------------
                if(array_key_exists("question_count", $errors))
                    for($j = 0; $j < count($errors["question_count"]); ++$j)
                    {
                        $key = $errors["question_count"][$j];
                        $value = (strpos($key, '.min.') !== false) ? 0 : 1; 
                        array_push($errorsJson, Lang::get('validator.'.$key, ["name" => "nombre de question", "value" => $value]));
                    }

                //error
                return response()->json(["error" => true, "message" => $errorsJson, "data" => []]);
            }
            else
            {
                $template = Template::find($id);
                $theme = Theme::find($request->theme_id);
                
                $template->themes()->detach(array($theme->id));
                $template->themes()->save($theme, array('question_count' => $request->question_count));

                return response()->json(["error" => false, "message" => Lang::get('template.themeAdd', ["name" => $theme->name]), "data" => ["template"=>$template, "theme"=>$theme]]);
                
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
        
    /**
     * @api {delete} /templates/{id}/themes/{theme_id} link a themes with a templates
     * @apiName Theme remove
     * @apiGroup Templates
     *
     * @apiParam {Number} id Template unique ID
     * @apiParam {Number} theme_id Theme unique ID
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data 
     */
    public function deleteRemoveTheme($id, $theme_id)
    {
        try
        {
            $template = Template::find($id);
            
            if(!$template)
                return response()->json(["error" => true, "message" => Lang::get('template.notFound'), "data" => []]);
            else
            {
                $theme = Theme::find($theme_id);
                $template->themes()->detach(array($theme->id));
                
                return response()->json(["error" => false, "message" => Lang::get('template.themeRemove', ['name' => $theme->name]), "data" => []]);
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    /**
    * @api {get} /templates/select2 select2
    * @apiName select2
    * @apiGroup Templates
    *
    *
    * @apiSuccess {Boolean} error an error occur
    * @apiSuccess {String} message description of action
    * @apiSuccess {Array} data current select2 data
    */
    public function getSelect2(Request $request)
    {
        try
        {
            $q = $request->q;
            $templates = Template::where('name', 'LIKE', '%'.$q.'%')->orderBy('name', 'desc')->get();
            
            return response()->json(["error" => false, "message" => '', "data" => $templates]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
}

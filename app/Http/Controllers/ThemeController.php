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
        
    //----------------------------
    //API ------------------------
    //----------------------------
    
     /**
     * @api {get} /themes Request Themes information
     * @apiName getAll
     * @apiGroup Themes
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data all themes
     */
    public function getAll(Request $request)
    {
        try
        {
            $themes = Theme::orderBy('name');
            if($request->has('page'))
            {
                 $page = $request->input('page');
                 $results = $themes->paginate(8);
                 
                 if($results->lastPage() < $page)
                 {
                    $request->replace(array('page' => $results->lastPage())); //change the page
                    $results = $themes->paginate(8);
                 }                 

                 return response()->json(["error"=> false, "message" =>"", "data" => $results->toArray()]);
            }
            
            $themes = Theme::all();
            return response()->json(["error"=> false, "message" =>"", "data" => $themes]);

        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
     /**
     * @api {delete} /themes/{id} delete a specific theme
     * @apiName delete
     * @apiGroup Themes
     *
     * @apiParam {Number} id Theme unique ID
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data current deleted theme
     */
    public function deleteDelete($id)
    {
        try
        {
            $theme = Theme::find($id);
            
            if(!$theme)
                return response()->json(["error" => true, "message" => Lang::get('theme.notFound'), "data" => []]);
            else
            {
                $theme->delete();
                return response()->json(["error" => true, "message" => Lang::get('theme.delete', ["name" => $theme->name]), "data" => $theme]);
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    /**
     * @api {post} /themes/ Add theme in database
     * @apiName Add
     * @apiGroup Themes
     *
     * @apiParam {String} name Theme name
     * @apiParam {String} description Theme description
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data current new theme
     */
    public function postAdd(Request $request)
    {
        try
        {
            //rules to apply of each field
            $rules = array(
                'name'             => 'required|min:2|max:25',
                'description'      => 'required|min:10|max:100',
            );
            
            //try to validate
            $validator = Validator::make($request->all(), $rules);
            if ($validator->fails()) 
            {
                $errors = $validator->messages()->getMessages();
                $errorsJson = array();
                $fields = array("name", "description");
                
                //----
                //Name
                //----
                if(array_key_exists("name", $errors))
                    for($i = 0; $i < count($errors["name"]); $i++)
                    {
                        $key = $errors["name"][$i];
                        $value = (strpos($key, '.min.') !== false) ? 2 : 25; 
                        array_push($errorsJson,  Lang::get('validator.'.$key, ["name" => "Nom", "value" => $value]));
                    }
                    
                //-----------
                //Description
                //-----------
                if(array_key_exists("description", $errors))
                    for($i = 0; $i < count($errors["description"]); $i++)
                    {
                       $key = $errors["description"][$i];
                       $value = (strpos($key, '.min.') !== false) ? 10 : 100; 
                       array_push($errorsJson,  Lang::get('validator.'.$errors["description"][$i], ["name" => "Déscription", "value" => $value]));
                    }
                    
                //error
                return response()->json(["error" => true, "message" => $errorsJson, "data" => []]);
            }
            else //ok
            {
                $theme = new Theme();
                $theme->name = $request->input('name');
                $theme->description = $request->input('description');
                $theme->save();
                
                return response()->json(["error" => false, "message" => Lang::get('theme.add', ["name" => $theme->name]), "data" => $theme]);
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
     /**
     * @api {get} /themes/{id}/questions All questions of the current theme
     * @apiName getQuestionsByTheme
     * @apiGroup Themes
     *
     * @apiParam {Number} id Theme id
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data All questions of theme
     */
    public function getQuestionsByTheme($id)
    {
        try
        {
             $theme = Theme::find($id);
            
            if(!$theme)
                return response()->json(["error" => true, "message" => Lang::get('theme.notFound'), "data" => []]);
            else
            {
                return response()->json(["error" => true, "message" => "", "data" => $theme->questions()->get()]);
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
}

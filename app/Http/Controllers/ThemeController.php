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
    
    public function deleteDelete($id)
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
    
    public function postAdd(Request $request)
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
}

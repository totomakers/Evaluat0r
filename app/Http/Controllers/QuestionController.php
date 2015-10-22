<?php

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Lang;

use Auth;
use App\Http\Controllers\Controller;
use App\Models\Question;

class QuestionController extends Controller
{
    public function __construct()
    {
    }
    
     /**
     * getAll() return one Theme in database
     * @return jsonArray return a json array with all accounts
     */
     public function getAll()
    {
        try
        {
            $questions = Question::all();
            return response()->json(["error"=> false, "message" =>"", "data" => $questions]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
     /**
     * getByTheme() return one Theme in database
     * @return jsonArray return a json array with all accounts
     */
    public function getByTheme($id)
    {
        try
        {
            $theme = Theme::find($id);
        
            //if we can't get account
            if($theme === NULL)
                return response()->json(["error" => true, "message" => Lang::get('theme.notFoundById', ["id" => $id]), "data" => []]);
            
            //return wanted account
            return response()->json(["error" => false, "message" => "", "data" => $theme]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    public function deleteDelete($id)
    {
        $question = Question::find($id);
        
        if(!$theme)
            return response()->json(["error" => true, "message" => Lang::get('question.notFound'), "data" => []]);
        else
        {
            $theme->delete();
            return response()->json(["error" => true, "message" => Lang::get('question.delete', ["name" => $theme->name]), "data" => $theme]);
        }
    }
    
    public function postAdd(Request $request)
    {
        //rules to apply of each field
        $rules = array(
            'wording'             => 'required|min:10|max:100',
        );
        
        //try to validate
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) 
        {
            $errors = $validator->messages()->getMessages();
            $errorsJson = array();
            $fields = array("wording");
            
            //----
            //wording
            //----
            if(array_key_exists("wording", $errors))
                for($i = 0; $i < count($errors["wording"]); $i++)
                {
                    $key = $errors["wording"][$i];
                    $value = (strpos($key, '.min.') !== false) ? 10 : 100; 
                    array_push($errorsJson,  Lang::get('validator.'.$key, ["wording" => "Libelle", "value" => $value]));
                }
				
            //error
            return response()->json(["error" => true, "message" => $errorsJson, "data" => []]);
        }
        else //ok
        {
            $question = new Question();
            $question->wording = $request->input('wording');
            $question->save();
            
            return response()->json(["error" => false, "message" => Lang::get('theme.add', ["name" => $theme->name]), "data" => $theme]);
        }
    }
}

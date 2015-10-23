<?php

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Lang;

use Auth;
use App\Http\Controllers\Controller;
use App\Models\Question;
use App\Models\Theme;

class QuestionController extends Controller
{
    public function __construct()
    {
    }

     /**
     * @api {get} /question Request Questions information
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
            $questions = Question::all();
            return response()->json(["error"=> false, "message" =>"", "data" => $questions]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }

    /**
     * @api {post} /questions Add questions
     * @apiName getAll
     * @apiGroup Themes
     *
     * @apiParam {String} wording question content in markdown
     * @apiParam {Array} answers array of answer
     * @apiParam {Number} themes_id theme id
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data Data of the theme
     */
    public function postAdd(Request $request)
    {
        //rules to apply of each field
        $rulesQuestion = array(
            'wording'             => 'string|required|min:10',
            'theme_id'            => 'integer|required|exists:theme,id',
            'answers'             => 'array|required',
        );
        
        $rulesAnswer = array(
            'wording'       => 'string|required|min:1',
            'good'          => 'boolean|required',
        );
        
        $errorsJson = array();
        
        $validatorQuestion = Validator::make($request->all(), $rulesQuestion);
        if ($validatorQuestion->fails()) 
        {
            $errors = $validatorQuestion->messages()->getMessages();

            //--------
            //wording
            //--------
            if(array_key_exists("wording", $errors))
                for($i = 0; $i < count($errors["wording"]); $i++)
                {
                    $key = $errors["wording"][$i];
                    $value = (strpos($key, '.min.') !== false) ? 10 : 0; 
                    array_push($errorsJson,  Lang::get('validator.'.$key, ["name" => "Libelle", "value" => $value]));
                }
               
               
            //--------
            //theme_id
            //--------
            if(array_key_exists("theme_id", $errors))
            {
                for($i = 0; $i < count($errors["theme_id"]); $i++)
                {
                    $key = $errors["theme_id"][$i];
                    $value = "";
                    array_push($errorsJson,  Lang::get('validator.'.$key, ["name" => "Theme", "value" => $value]));
                }
            }
            
            //----------
            //answer
            //----------
            if(array_key_exists("answers", $errors))
            {
                for($i = 0; $i < count($errors["answers"]); $i++)
                {
                    $key = $errors["answers"][$i];
                    $value = "";
                    array_push($errorsJson,  Lang::get('validator.'.$key, ["name" => "réponse", "value" => $value]));
                }
            }
            
            //-------
            //error -
            return response()->json(["error" => true, "message" => $errorsJson, "data" => []]);
        }
        else
        {
            $answersError = false;
            /*
            for($i = 0; i < $request->answers()->size(); $i++)
            {
                $validatorAnswer = Validator::make($request->answers()[$i], $rulesAnswer);
                if($validatorAnswer->fail)
                {
                     $answersError = true;
                }
            }
            */
            
            if(!$answersError)
            {
                $question = new Question();
                $question->wording = $request->wording;
                $question->theme_id = $request->theme_id;
                $question->save();
            
                return response()->json(["error" => false, "message" => "", "data" => $question]);
            }
            else
            {
                //-------
                //error -
                return response()->json(["error" => true, "message" => $errorsJson, "data" => []]);
            }
        }
    }
}

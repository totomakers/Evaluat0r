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
use App\Models\Answer;

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
            $questions = Question::with('answers')->all();
            return response()->json(["error"=> false, "message" =>"", "data" => $questions]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    /**
     * @api {delete} /question/{id} delete a specific question
     * @apiName delete
     * @apiGroup Questions
     *
     * @apiParam {Number} id Question unique ID
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data current deleted question
     */
    public function deleteDelete($id)
    {
        try
        {
            $question = Question::find($id);
            
            if(!$question)
                return response()->json(["error" => true, "message" => Lang::get('question.notFound'), "data" => []]);
            else
            {
                $question->delete();
                return response()->json(["error" => true, "message" => Lang::get('question.delete'), "data" => $question]);
            }
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
        try
        {
            //rules to apply of each field
            $rulesQuestion = array(
                'wording'             => 'string|required|min:10',
                'theme_id'            => 'integer|required|exists:theme,id',
                'answers'             => 'array|required',
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
                        $value = (strpos($key, '.min.') !== false) ? 10 : ""; 
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
                //==============
                //QUESTION =====
                //==============
                
                 $rulesAnswer = array(
                    'wording'       => 'string|required|min:1',
                    'good'          => 'string|required|in:true,false',
                 );
            
                $answersError = false;
                for($i = 0; $i < count($request->answers); ++$i)
                {
                    $validatorAnswer = Validator::make($request->answers[$i], $rulesAnswer);
                    if($validatorAnswer->fails())
                    {
                        $errors = $validatorAnswer->messages()->getMessages();
                        $answersError = true;
                         
                        //---------
                        //wording--
                        //---------
                        if(array_key_exists("wording", $errors))
                            for($j = 0; $j < count($errors["wording"]); ++$j)
                            {
                                $key = $errors["wording"][$j];
                                $value = (strpos($key, '.min.') !== false) ? 10 : ""; 
                                array_push($errorsJson,  "Réponse " . $i . ":" . Lang::get('validator.'.$key, ["name" => "Libelle", "value" => $value]));
                            }
                            
                        //------
                        //good--
                        //------
                        if(array_key_exists("good", $errors))
                            for($j = 0; $j < count($errors["good"]); ++$j)
                            {
                                $key = $errors["good"][$j];
                                $value = "";
                                array_push($errorsJson,  "Réponse " . $i . ":". Lang::get('validator.'.$key, ["name" => "bonne réponse", "value" => $value]));
                            }
                    }
                }
                
                //------------
                //Insertion --
                //------------
                
                if(!$answersError)
                {
                    $question = new Question();
                    $question->wording = $request->wording;
                    $question->theme_id = $request->theme_id;
                    $question->save();
                    
                    for($i = 0; $i < count($request->answers); ++$i)
                    {
                        $answer = new Answer();
                        $answer->wording = $request->answers[$i]["wording"];
                        $answer->good = ($request->answers[$i]["good"] == "true") ? true : false;
                        $answer->question_id = $question->id;
                        $answer->save();
                    }
                    
                    $question = Question::with('answers')->find($question->id);
                    return response()->json(["error" => false, "message" => Lang::get('question.add'), "data" => $question]);
                }
                else
                {
                    //-------
                    //error -
                    //-------
                    return response()->json(["error" => true, "message" => $errorsJson, "data" => []]);
                }
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
}

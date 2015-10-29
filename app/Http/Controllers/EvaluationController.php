<?php

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Lang;

use Auth;
use Carbon\Carbon;
use App\Http\Controllers\Controller;
use App\Models\Evaluation;
use App\Models\Account;
use App\Models\Session;
use App\Models\Answer;
use App\Models\Question;

class EvaluationController extends Controller
{
    public function __construct()
    {
    }
        
    //----------------------------
    //API ------------------------
    //----------------------------
    
    /**
    * @api {get} /evaluations Request Current evaluation by status
    * @apiName getAll
    * @apiGroup Themes
    *
    * @apiParam {String} Status of evalution available, in_progress, ended
    *
    * @apiSuccess {Boolean} error an error occur
    * @apiSuccess {String} message description of action
    * @apiSuccess {Array} data all themes
    * @apiSampleRequest off
    */
    public function getCurrentEvaluation(Request $request)
    {
        try
        {
            $account = Auth::user();
            $evaluations = Evaluation::with('session')->where('account_id', $account->id); //current account session
            
            if($request->has('status'))
            {
                $status = $request->status;
                
                switch($status)
                {
                    case 'available':
                        //all sessions not in evaluation
                        $sessions = $account->sessions()
                                            ->whereNotIn('id', $evaluations->lists('session_id')->toArray())
                                            ->where('start_date', '<=', Carbon::today())
                                            ->get();

                        return response()->json(["error"=> false, "message" =>"", "data" => $sessions]);
                    break;
                    
                    case 'in_progress':
                        $evaluations =  $evaluations->where('validate', '=', false)
                                                    ->whereHas('session', function ($query) 
                                                    {
                                                        $query->where('end_date', '>', Carbon::today());
                                                    })->get();
                        
                        return response()->json(["error"=> false, "message" =>"", "data" => $evaluations]);
                    break;

                    case 'ended':
                        //with valide = true or date past
                        $evaluations =  $evaluations->whereHas('session', function ($query) 
                                                    {
                                                        $query->where('end_date', '>', Carbon::today());
                                                    })->orWhere('validate', '=', true)->get();
           
                        return response()->json(["error"=> false, "message" =>"", "data" => $evaluations]);
                    break;
                }
            }
            
            return response()->json(["error"=> true, "message" =>"", "data" => []]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    private function checkEvaluationUser()
    {
        $account = Auth::user();
        return NULL;
    }
    
    public function getStart($session_id)
    {
        try
        {
            $account = Auth::user();
            $session = Session::find($session_id);

            $evaluation = Evaluation::with('session')->where('account_id', $account->id)->where('session_id', $session_id)->first();
            if($evaluation)
                return response()->json(["error"=> true, "message" =>Lang::get('evaluation.alreadyStart'), "data" => []]);
            
            //else we can create a new entry
            $evaluation = new Evaluation();
            $evaluation->account_id = $account->id;
            $evaluation->session_id = $session_id;
            $evaluation->start = Carbon::now();
            $evaluation->validate = false;
            $evaluation->save();
           
            return response()->json(["error"=> false, "message" => Lang::get('evaluation.start'), "data" => $evaluation]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    public function getQuestions($id)
    {
        try
        {
            $account = Auth::user();
            $reponse = $this->checkEvaluationUser();
            if($reponse) return $reponse;
            
            //check if already start
            $evaluation = Evaluation::find($id)->first();
            if(!$evaluation) 
                return response()->json(["error"=> true, "message" =>Lang::get('evaluation.notStart'), "data" => []]);
                
            //check if not validate
            if($evaluation->validate)
                return response()->json(["error"=> true, "message" =>Lang::get('evaluation.alreadyValidate'), "data" => []]);
                
            //check if date available
            $session = Session::find($evaluation->session_id);
            if($session->end_date < Carbon::today())
                return response()->json(["error"=> true, "message" =>Lang::get('evaluation.ended'), "data" => []]);
                
            //check if duration not elapse
            if($session->duration != '00:00:00')
            {
                $duration =  Carbon::createFromFormat('H:i:s', $session->duration);
                
                $evaluationEndDateTime = $evaluation->start
                                                    ->addHour($duration->hour)
                                                    ->addMinute($duration->minute)
                                                    ->addSecond($duration->second);
                                                    
                if($evaluationEndDateTime <= Carbon::now())                            
                    return response()->json(["error"=> true, "message" =>Lang::get('evaluation.timeElapse'), "data" => $evaluationEndDateTime]);                                    
            }
            

            $questions = Session::with('questions')->find($evaluation->session_id);
            return response()->json(["error"=> false, "message" => "", "data" => $questions]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    public function getAnswers($id)
    {
        try
        {
            $account = Auth::user();

            //check if already start
            $evaluation = Evaluation::find($id)->first();
            if(!$evaluation) 
                return response()->json(["error"=> true, "message" =>Lang::get('evaluation.notStart'), "data" => []]);

            $answers = $evaluation->answers()->select('answer_id')->get();
            
            return response()->json(["error"=> false, "message" => "", "data" => $answers]);                   
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    public function postAnswers($id, Request $request)
    {
        try
        {
            //rules to apply of each field
            $rules = array(
                'answers' => 'array',
            );
            
            $errorsJson = array();
            $validator = Validator::make($request->all(), $rules);
            
            if ($validator->fails()) 
            {
                $errors = $validator->messages()->getMessages();
        
                //----------
                //answer
                //----------
                if(array_key_exists("answers", $errors))
                {
                    for($i = 0; $i < count($errors["answers"]); $i++)
                    {
                        $key = $errors["answers"][$i];
                        $value = "";
                        array_push($errorsJson,  Lang::get('validator.'.$key, ["name" => "réponses", "value" => $value]));
                    }
                }
                
                //-------
                //error -
                return response()->json(["error" => true, "message" => $errorsJson, "data" => []]);
            }
            else
            {
                $account = Auth::user();

                //check if already start
                $evaluation = Evaluation::find($id)->first();
                if(!$evaluation) 
                    return response()->json(["error"=> true, "message" =>Lang::get('evaluation.notStart'), "data" => []]);
                    
                //check if not validate
                if($evaluation->validate)
                    return response()->json(["error"=> true, "message" =>Lang::get('evaluation.alreadyValidate'), "data" => []]);
                    
                //check if date available
                $session = Session::find($evaluation->session_id);
                if($session->end_date < Carbon::today())
                    return response()->json(["error"=> true, "message" =>Lang::get('evaluation.ended'), "data" => []]);
                    
                //check if duration not elapse
                if($session->duration != '00:00:00')
                {
                    $duration =  Carbon::createFromFormat('H:i:s', $session->duration);
                    
                    $evaluationEndDateTime = $evaluation->start
                                                        ->addHour($duration->hour)
                                                        ->addMinute($duration->minute)
                                                        ->addSecond($duration->second);
                                                        
                    if($evaluationEndDateTime <= Carbon::now())                            
                        return response()->json(["error"=> true, "message" => Lang::get('evaluation.timeElapse'), "data" => $evaluationEndDateTime]);                                    
                }

                //answers id
                $answersId = array();
                for($i = 0; $i < count($request->answers); $i++)
                    $answersId[] = intval($request->answers[$i]);
                
                //questions
                $questionsNeedToAdd = Answer::whereIn('id', $answersId)->distinct('question_id')->lists('question_id')->toArray();
                $questionsIn = $evaluation->questions()->lists('question_id')->toArray();
               
                $questionsNeedToAdd = array_diff($questionsNeedToAdd, $questionsIn);
                $evaluation->questions()->attach($questionsNeedToAdd); //attach all question
                
                //------
                //Answer
                //------
                $evaluation->answers()->sync($answersId);
                
                return response()->json(["error"=> false, "message" => Lang::get('evaluation.save'), "data" => []]);                   
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    public function getTimer($id)
    {
        try
        {
             $account = Auth::user();

            //check if already start
            $evaluation = Evaluation::find($id)->first();
            if(!$evaluation) 
                return response()->json(["error"=> true, "message" =>Lang::get('evaluation.notStart'), "data" => []]);
                
            //check if not validate
            if($evaluation->validate)
                return response()->json(["error"=> true, "message" =>Lang::get('evaluation.alreadyValidate'), "data" => []]);
                
            //check if date available
            $session = Session::find($evaluation->session_id);
            if($session->end_date < Carbon::today())
                return response()->json(["error"=> true, "message" =>Lang::get('evaluation.ended'), "data" => []]);
                
            //check if duration not elapse
            if($session->duration != '00:00:00')
            {
                $duration =  Carbon::createFromFormat('H:i:s', $session->duration);
                
                $evaluationEndDateTime = $evaluation->start
                                                    ->addHour($duration->hour)
                                                    ->addMinute($duration->minute)
                                                    ->addSecond($duration->second);
                                                    
                                              
                $now = Carbon::now();                                    
                                                    
                if($evaluationEndDateTime <= $now)                            
                    return response()->json(["error"=> true, "message" => Lang::get('evaluation.timeElapse'), "data" => $evaluationEndDateTime]);
                else
                {
                     $evaluationTimeLeft = $evaluationEndDateTime->subHours($now->hour)
                                                                 ->subMinute($now->minute)
                                                                 ->subSecond($now->second);
                                                                 
                    return response()->json(["error"=> false, "message" => "", "data" => $evaluationTimeLeft->format('H:i:s')]);
                }
            }
            
            return response()->json(["error"=> false, "message" => "", "data" => '00:00:00']);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
}

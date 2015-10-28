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
                                            ->whereNotIn('id', $evaluations->get()->pluck('session_id'))
                                            ->where('start_date', '<=', Carbon::today())
                                            ->get();

                        return response()->json(["error"=> false, "message" =>"", "data" => $sessions]);
                    break;
                    
                    case 'in_progress':
                        $evaluations =  $evaluations->whereHas('session', function ($query) 
                                        {
                                            $query->where('end_date', '<=', Carbon::today());
                                        })->where('validate', '=', false)->get();
                        
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
    
    public function getStart($session_id)
    {
        try
        {
            $account = Auth::user();
            $session = Session::find($session_id);
            
            //check if user is subscribe
            $session = $session->candidates()->where('account_id', $account->id)->first();
            if(!$session)
                return response()->json(["error"=> true, "message" =>Lang::get('evaluation.notCandidate'), "data" => []]);
            
            //check if evaluation available
            if($session->start_date >= Carbon::today())
                return response()->json(["error"=> true, "message" =>Lang::get('evaluation.candidateEarlier'), "data" => []]);
            
            //check if already start
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
}

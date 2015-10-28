<?php

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Lang;
use Carbon\Carbon;

use Auth;
use App\Http\Controllers\Controller;

use App\Models\Account;
use App\Models\Question;
use App\Models\Session;
use App\Models\Template;

class SessionController extends Controller
{
    public function __construct()
    {
    }

    /**
    * @api {get} /sessions Request Sessions information
    * @apiName getAll
    * @apiGroup Sessions
    *
    * @apiSuccess {Boolean} error an error occur
    * @apiSuccess {String} message description of action
    * @apiSuccess {Array} data Data of all sessions
    */
    public function getAll(Request $request)
    {
        try
        {
            $sessions = Session::orderBy('name')->orderBy('start_date', 'desc');
            
            if($request->has('page'))
            {
                 $page = $request->input('page');
                 $results = $sessions->paginate(8);
                 
                 if($results->lastPage() < $page)
                 {
                    $request->replace(array('page' => $results->lastPage())); //change the page
                    $sessions = $sessions->paginate(8);
                 }                 

                 return response()->json(["error"=> false, "message" =>"", "data" => $results->toArray()]);
            }
            
            $sessions = Session::get();
            return response()->json(["error"=> false, "message" =>"", "data" => $sessions]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }

    /**
    * @api {get} /sessions/{id} Get wanted session info
    * @apiName getById();
    * @apiGroup Sessions
    *
    * @apiParam {Number} id Session unique Id
    *
    * @apiSuccess {Boolean} error an error occur
    * @apiSuccess {String} message description of action
    * @apiSuccess {Array} data wanted session
    */
    public function getById($id)
    {
        try
        {
            $session = Session::find($id);
            
            if(!$session)
                return response()->json(["error" => true, "message" => Lang::get('session.notFound'), "data" => []]);
            else
                return response()->json(["error" => false, "message" => "", "data" => $session]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    /**
     * @api {post} /sessions Try to create a new session
     * @apiName postAdd();
     * @apiGroup Sessions
     *
     * @apiParam {Number} model_id Model unique id
     * @apiParam {String} name Wanted name of session
     * @apiParam {Date} start_date Date when the session is available
     * @apiParam {Date} end_data Date when the session is unvailable
     * @apiParam {Time} Duration Time available for the candidate after he launch for the first time
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data wanted session
     */
    public function postAdd(Request $request)
    {
        try
        {
            //rules to apply of each field
            $rules = array(
                'name'          => 'required|min:2|max:50',
                'start_date'    => 'required|date_format:d/m/Y',
                'end_date'      => 'required|date_format:d/m/Y',
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

                //----------
                //name -----
                //----------
                if(array_key_exists("name", $errors))
                    for($j = 0; $j < count($errors["name"]); ++$j)
                    {
                        $key = $errors["name"][$j];
                        $value = (strpos($key, '.min.') !== false) ? 2 : 50; 
                        array_push($errorsJson, Lang::get('validator.'.$key, ["name" => "Nom", "value" => $value]));
                    }
                    
                //--------------
                //start_date --
                //--------------
                if(array_key_exists("start_date", $errors))
                    for($j = 0; $j < count($errors["start_date"]); ++$j)
                    {
                        $key = $errors["start_date"][$j];
                        $value = "";
                        array_push($errorsJson, Lang::get('validator.'.$key, ["name" => "Date de début", "value" => $value]));
                    }
                    
                //--------------
                //end_date -----
                //--------------
                if(array_key_exists("end_date", $errors))
                    for($j = 0; $j < count($errors["end_date"]); ++$j)
                    {
                        $key = $errors["end_date"][$j];
                        $value = "";
                        array_push($errorsJson, Lang::get('validator.'.$key, ["name" => "Date de fin", "value" => $value]));
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
            else
            {
                $session = new Session();
                $session->name = $request->name;
                $session->start_date = Carbon::createFromFormat('d/m/Y', $request->start_date);
                $session->end_date =  Carbon::createFromFormat('d/m/Y', $request->end_date);
                $session->duration = $request->duration;
                
                //Need to be inferior 
                if($session->start_date > $session->end_date)
                    return response()->json(["error" => true, "message" =>  Lang::get('session.badStartDate'), "data" => []]);
                
                //Need not to be today
                if($session->start_date < Carbon::today())
                    return response()->json(["error" => true, "message" =>  Lang::get('session.lowStartDate'), "data" => []]);
                
                //PRC need to be superieur 
                if($request->accepted_prc <= $request->ongoing_prc)
                {
                    array_push($errorsJson, Lang::get('session.onGoingPrcBadValue'));
                    return response()->json(["error" => true, "message" => $errorsJson, "data" => []]);
                }
                
                $session->accepted_prc = $request->accepted_prc;
                $session->ongoing_prc = $request->ongoing_prc;
                
                $session->save();
                return response()->json(["error" => false, "message" => Lang::get('session.add', ["name" => $session->name]), "data" => $session]);
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    
     /**
     * @api {put} /sessions/{id} Update Session informations
     * @apiName putUpdate();
     * @apiGroup Sessions
     *
     * @apiParam {Number} id Session unique Id
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data Updated Session
     */
    public function putUpdate($id, Request $request)
    {
        try
        {
            $session = Session::find($id);
            
            //session not found
            if(!$session)
                return response()->json(["error" => true, "message" => Lang::get('session.notFound'), "data" => []]);
            
            //rules to apply of each field
            $rules = array(
                'name'          => 'min:2|max:50',
                'start_date'    => 'date_format:d/m/Y',
                'end_date'      => 'date_format:d/m/Y',
                'duration'      => 'date_format:G:i',
                'accepted_prc'  => 'required|numeric|min:0|max:100',
                'ongoing_prc'   => 'required|numeric|min:0|max:100',
            );
            
            $errorsJson = array();
            
            //try to validate
            $validator = Validator::make($request->all(), $rules);
            if ($validator->fails()) 
            {
                $errors = $validator->messages()->getMessages();

                //----------
                //name -----
                //----------
                if(array_key_exists("name", $errors))
                    for($j = 0; $j < count($errors["name"]); ++$j)
                    {
                        $key = $errors["name"][$j];
                        $value = (strpos($key, '.min.') !== false) ? 2 : 50; 
                        array_push($errorsJson, Lang::get('validator.'.$key, ["name" => "Nom", "value" => $value]));
                    }
                    
                //--------------
                //start_date --
                //--------------
                if(array_key_exists("start_date", $errors))
                    for($j = 0; $j < count($errors["start_date"]); ++$j)
                    {
                        $key = $errors["start_date"][$j];
                        $value = "";
                        array_push($errorsJson, Lang::get('validator.'.$key, ["name" => "Date de début", "value" => $value]));
                    }
                    
                //--------------
                //end_date -----
                //--------------
                if(array_key_exists("end_date", $errors))
                    for($j = 0; $j < count($errors["end_date"]); ++$j)
                    {
                        $key = $errors["end_date"][$j];
                        $value = "";
                        array_push($errorsJson, Lang::get('validator.'.$key, ["name" => "Date de fin", "value" => $value]));
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
            else
            {
                if($request->has('name')) $session->name = $request->name;
                if($request->has('start_date')) $session->start_date = Carbon::createFromFormat('d/m/Y', $request->start_date);
                if($request->has('end_date')) $session->end_date =  Carbon::createFromFormat('d/m/Y', $request->end_date);
                if($request->has('duration')) $session->duration = $request->duration;
                if($request->has('accepted_prc')) $session->accepted_prc = $request->accepted_prc;
                if($request->has('ongoing_prc')) $session->ongoing_prc = $request->ongoing_prc;
                
                //Need to be inferior 
                if($session->start_date > $session->end_date)
                    return response()->json(["error" => true, "message" =>  Lang::get('session.badStartDate'), "data" => []]);
                
                //Need not to be today
                if($session->start_date < Carbon::today())
                    return response()->json(["error" => true, "message" =>  Lang::get('session.lowStartDate'), "data" => []]);
                    
                //PRC need to be superieur 
                if($session->accepted_prc <= $session->ongoing_prc)
                {
                    array_push($errorsJson, Lang::get('session.onGoingPrcBadValue'));
                    return response()->json(["error" => true, "message" => $errorsJson, "data" => []]);
                }
                
                $session->save();
                return response()->json(["error" => false, "message" =>  Lang::get('session.update', ['name' => $session->name]), "data" => $session]);
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
   /**
    * @api {delete} /sessions/{id} Delete Session informations
    * @apiName deleteDelete();
    * @apiGroup Sessions
    *
    * @apiParam {Number} id Session unique Id
    *
    * @apiSuccess {Boolean} error an error occur
    * @apiSuccess {String} message description of action
    * @apiSuccess {Array} data Updated Session
    */
    public function deleteDelete($id)
    {
        try
        {
            $session = Session::find($id);
            
            if(!$session)
                return response()->json(["error" => true, "message" => Lang::get('session.notFound'), "data" => []]);
            else
            {
                $session->delete();
                return response()->json(["error" => false, "message" => Lang::get('session.delete', ['name' => $session->name]), "data" => $session]);
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    //----------------------------------------
    //CANDIDATES -----------------------------
    //----------------------------------------
    
   /**
    * @api {get} /sessions/{id}/candidates Get session candidates
    * @apiName getCandidates($id);
    * @apiGroup Sessions
    *
    * @apiParam {Number} id Session unique Id
    *
    * @apiSuccess {Boolean} error an error occur
    * @apiSuccess {String} message description of action
    * @apiSuccess {Array} data Session candidates
    */
    public function getCandidates($id)
    {
        try
        {
            $session = Session::with('candidates')->find($id);
            
            if(!$session)
                return response()->json(["error" => true, "message" => Lang::get('session.notFound'), "data" => []]);
            else
                return response()->json(["error" => false, "message" => "", "data" => $session->candidates]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }

     /**
     * @api {post} /sessions/{id}/candidates Add new candidate
     * @apiName postAddCandidate();
     * @apiGroup Sessions
     *
     * @apiParam {Number} id Session unique id
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data Added account
     */
    public function postAddCandidate($id, Request $request)
    {
        //rules to apply of each field
        $rules = array(
            'account_id'  => 'required|integer|exists:account,id',
        );
        
        $errorsJson = array();
            
        //try to validate
        $validator = Validator::make($request->all(), $rules);
        if ($validator->fails()) 
        {
            $errors = $validator->messages()->getMessages();
            
            //--------------
            //account_id ----
            //---------------
            if(array_key_exists("account_id", $errors))
                for($j = 0; $j < count($errors["account_id"]); ++$j)
                {
                    $key = $errors["account_id"][$j];
                    array_push($errorsJson, Lang::get('validator.'.$key, ["name" => "Candidat"]));
                }
                
            return response()->json(["error" => true, "message" => $errorsJson, "data" => []]);
        }
        else
        {
            $session = Session::find($id);
            
            if(!$session)
                return response()->json(["error" => true, "message" => Lang::get('session.notFound'), "data" => []]);
        
            $accountFind = $session->candidates()->find($request->account_id);
            if($accountFind)
                return response()->json(["error" => true, "message" => Lang::get('session.candidateAlreadyMember')]);

            
            $account = Account::find($request->account_id);
            
            if(!$account)
                return response()->json(["error" => true, "message" => Lang::get('account.notFound'), "data" => []]);
                
            if($account->rank > 0)
                return response()->json(["error" => true, "message" => Lang::get('account.notRank0', ["email" => $account->email])]);
                
            $session->candidates()->detach(array($account->id));
            $session->candidates()->save($account, array('created_at' => new Carbon()));
            return response()->json(["error" => false, "message" => Lang::get('session.candidateAdd', ["name" => $account->lastname . ' ' . $account->firstname]), "data" => $account]);
        }
    }
     
     /**
     * @api {delete} /sessions/{id}/candidates/{account_id} Remove a candidate
     * @apiName deleteRemoveCandidate();
     * @apiGroup Sessions
     *
     * @apiParam {Number} id Session unique id
     * @apiParam {Number} account_id Account unique id
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data Remove account id, firstname and lastname
     */
    public function deleteRemoveCandidate($id, $account_id)
    {
        try
        {
            $session = Session::find($id);
            
            if(!$session)
                return response()->json(["error" => true, "message" => Lang::get('session.notFound'), "data" => []]);
            else
            {
                $account = Account::find($account_id);
                
                if(!$account)
                    return response()->json(["error" => true, "message" => Lang::get('account.notFound'), "data" => []]);
                
                $session->candidates()->detach(array($account->id));
                
                return response()->json(["error" => false, "message" => Lang::get('session.candidateRemove', ['name' => $account->firstname . ' ' . $account->lastname]), "data" => []]);
            }
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    //---------------------
    //QUESTIONS -----------
    //---------------------

    /**
     * @api {get} /sessions/{id}/questions Return all questions of session
     * @apiName getQuestions();
     * @apiGroup Sessions
     *
     * @apiParam {Number} $id Session unique id
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data All questions of the sessions
     */
     public function getQuestions($id)
     {
         try
        {
            $session = Session::with('questions')->find($id);
            
            if(!$session)
                return response()->json(["error" => true, "message" => Lang::get('session.notFound'), "data" => []]);
            else
                return response()->json(["error" => false, "message" => "", "data" => $session->questions]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
     }
     
     
    /**
     * @api {put} /sessions/{id}/questions/from/{theme_id} Generate new questions for the sessions
     * @apiName putGenerateQuestion();
     * @apiGroup Sessions
     *
     * @apiParam {Number} $id Session unique id
     * @apiParam {Number} $theme_id Theme unique id
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data New questions of the sessions
     */
    public function putGenerateQuestion($id, $template_id)
    {
        $template = Template::find($template_id);
        $session = Session::find($id);
        
        //check template
        if(!$template) 
            return response()->json(["error" => true, "message" => Lang::get('session.templateNotFound'), "data" => ""]);
            
        //check session
        if(!$session)
            return response()->json(["error" => true, "message" => Lang::get('session.notFound'), "data" => ""]);
        
        if($session->questions()->count() > 0)
        {
            //check date
            $today = Carbon::today();
            if($session->start_date <= $today)
                return response()->json(["error" => true, "message" => Lang::get('session.alreadyStart'), "data" => ""]);
        }

           
        //--------------------
        //GENERATE QUESTION --
        //--------------------
           
        $selectedQuestions = array();
        $message = array();
        $templateThemes = $template->themes()->withPivot('question_count')->get();
        
        for($i = 0; $i < count($templateThemes); ++$i)
        {
            $currentTheme = $templateThemes[$i];
            $questions = Question::where('theme_id', $currentTheme->id)->get();
            
            $questionCount = $currentTheme->pivot->question_count;
            if(count($questions) < $questionCount)
            {
                $questionCount = count($questions);
                $message[] =  Lang::get('session.warningNotEnougthQuestion', ['name' => $currentTheme->name]);
            }
            
            $questionsId = array();
            for($j = 0; $j < count($questions); ++$j)
                $questionsId[] = $questions[$j]->id;
                
            for($k = 0; $k < $questionCount; ++$k)
            {
                $index = random_int(0, count($questionsId)-1);
                $selectedQuestions[] = $questionsId[$index];
                array_splice($questionsId, $index, 1);
            }
        }
        
        $session->questions()->detach($selectedQuestions);
        $session->questions()->attach($selectedQuestions);

        $questionsForSession = Question::with('answers')->whereIn('id', $selectedQuestions)->get();
        
        $message[] = Lang::get('session.generateQuestion');
        return response()->json(["error" => false, "message" => $message, "data" => $questionsForSession]);
    }
}

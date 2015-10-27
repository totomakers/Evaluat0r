<?php

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Lang;

use Auth;
use App\Http\Controllers\Controller;
use App\Models\Session;


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
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data Data of all sessions
     */
    public function getAll()
    {
        try
        {
            $sessions = Session::all();
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
     * @apiParam {Time} timer Time available for the candidate after he launch for the first time
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data wanted session
     */
    public function postAdd(Request $request)
    {
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
    public function putUpdate($id)
    {
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
    }
    
     /**
     * @api {post} /sessions/{id}/candidates Add new candidate
     * @apiName addCandidate();
     * @apiGroup Sessions
     *
     * @apiParam {Number} account_id Account unique id
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data Added account id, firstname and lastname
     */
    public function addCandidate($id, Request $request)
    {
    }
     
     /**
     * @api {delete} /sessions/{id}/candidates/{account_id} Remove a candidate
     * @apiName removeCandidate();
     * @apiGroup Sessions
     *
     * @apiParam {Number} id Session unique id
     * @apiParam {Number} account_id Account unique id
     *
     * @apiSuccess {Boolean} error an error occur
     * @apiSuccess {String} message description of action
     * @apiSuccess {Array} data Remove account id, firstname and lastname
     */
    public function removeCandidate($id, Request $request)
    {
        
    }

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
     }
}

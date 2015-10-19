<?php

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Lang;

use Auth;
use App\Http\Controllers\Controller;
use App\Models\Account;

class AccountController extends Controller
{
    public function __construct()
    {
    }

    public function vueLogin()
    {
         return view('account.login');
    }
    
    /**
     * getAll() return all Account in database
     * @return jsonArray return a json array with all accounts
     */
    public function getAll()
    {
        try
        {
            $accounts = Account::all();
            return response()->json(["error"=> false, "message" =>"", "data" => $accounts]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    /**
     * getById return a specific account by id
     * @param  integer $id wanted id
     * @return jsonArray return a json array with wanted account
     */
    public function getById($id)
    {
        try
        {
            $account = Account::find($id);
        
            //if we can't get account
            if($account === NULL)
                return response()->json(["error" => true, "message" => Lang::get('account.notFoundById', ["id" => $id]), "data" => []]);
            
            //return wanted account
            return response()->json(["error" => false, "message" => "", "data" => $account]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }

    /**
     * postLogin check if username and password is correct
     * @return jsonArray return a json array with authToken ;)
     */
    public function postLogin(Request $request)
    {
        $username = $request->input('username');
        $password = $request->input('password');

        if(Auth::attempt(['username' => $username, 'password' => $password]))
        {
            return response()->json(["error" => false, "message" => Lang::get('account.loginOk')]);
        }
        else
            return response()->json(["error" => true, "message" => Lang::get('account.loginFail')]);
    }


    /**
     * getLogout delete the current session and redirect to call page
     */
    public function getLogout()
    {

    }
}

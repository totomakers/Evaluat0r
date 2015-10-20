<?php namespace App\Http\Middleware;

use Auth;
use Lang;
use Closure;

class AuthRank {

    public function handle($request, Closure $next, $rank)
    {
        $response = $next($request);
        
        $user = Auth::user();
        (!$user) ? $langKey = 'account.shouldBeLogged' : $langKey = 'account.rankTooLow';
        
        if(!$user || $user->rank < $rank)
        {
            if(is_a($response, "Illuminate\Http\JsonResponse"))
                return response()->json(["error" => true, "message" => Lang::get($langKey), "data" => []]);
            else
                return redirect()->route('appli::login')->with(['error' => true, 'message' => Lang::get($langKey)]);
        }
        
        return $response; //continue
    }
}


       
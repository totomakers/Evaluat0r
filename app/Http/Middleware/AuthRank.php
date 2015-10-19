<?php namespace App\Http\Middleware;

use Auth;
use Lang;
use Closure;

class AuthRank {

    public function handle($request, Closure $next, $rank)
    {
        $response = $next($request);
        
        $user = Auth::user();
        if(!$user || $user->rank < $rank)
        {
            ($user) ? $langKey = 'account.shouldBeLogged' : $langKey = 'account.rankTooLow';
            return redirect()->route('appli::home')->with(['error' => true, 'message' => Lang::get($langKey)]);
        }
        
        return $response;
    }
}


       
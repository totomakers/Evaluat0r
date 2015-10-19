<?php

namespace App\Providers;

use App\Models\Account;
use App\Providers\AccountProvider;
use Illuminate\Support\ServiceProvider;

class AuthProvider extends ServiceProvider
{
    /**
     * Perform post-registration booting of services.
     *
     * @return void
     */
    public function boot()
    {
        \Auth::extend('evaluat0r.auth',function()
        {
            return new AccountProvider(new Account);
        });
    }

    /**
     * Register bindings in the container.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}
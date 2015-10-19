<?php 
namespace App\Providers;

use App\Models\Account;
use Illuminate\Contracts\Auth\Authenticatable;
use Illuminate\Contracts\Auth\UserProvider;

class AccountProvider implements UserProvider 
{
    protected $model;

    public function __construct(Authenticatable $model)
    {
        $this->model = $model;
    }

    /**
    * Retrieve a user by their unique identifier.
    *
    * @param  mixed  $identifier
    * @return App\Models\Auth\Account|null
    */
    public function retrieveById($identifier)
    {
        return Account::find($identifier);
    }

    /**
     * Retrieve a user by their unique identifier and "remember me" token.
     *
     * @param  mixed   $identifier
     * @param  string  $token
     * @return App\Models\Auth\Account|null
     */
    public function retrieveByToken($identifier, $token)
    {
        return Account::where('id = ? and remember_token = ?', $identifier, $token)->first();
    }

    /**
     * Update the "remember me" token for the given user in storage.
     *
     * @param  App\Models\Auth\Account $user
     * @param  string  $token
     * @return void
     */
    public function updateRememberToken(Authenticatable $user, $token)
    {
        $user->remember_token = $token;
        $user->save(); 
    }

    /**
     * Retrieve a user by the given credentials.
     *
     * @param  array  $credentials
     * @return App\Models\Auth\Account|null
     */
    public function retrieveByCredentials(array $credentials)
    {
        $hashedPassword = $this->hashPassword($credentials['username'], $credentials['password']);
        return Account::where('email', '=', $credentials['username'])->where('sha1_pass', '=', $hashedPassword)->first();
    }

    /**
     * Validate a user against the given credentials.
     *
     * @param  App\Models\Auth\Account $user
     * @param  array  $credentials
     * @return bool
     */
    public function validateCredentials(Authenticatable $user, array $credentials)
    {
        $hashedPassword = $this->hashPassword($credentials['username'], $credentials['password']);
        return strtoupper($user->sha1_pass) === strtoupper($hashedPassword);
    }

    /**
     * Hash password for TrinityCore
     * @param  string $username username
     * @param  string $password password not encrypted
     * @return string           hashed password
     */
    private function hashPassword($username, $password)
    {
        return sha1(strtoupper($username).':'.$password);
    }
}
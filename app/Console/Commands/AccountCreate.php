<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Validator;
use Auth;
use App\Models\Account;

class AccountCreate extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'account:create 
                            {email : Email of the user}
                            {password : Wanted password }
                            {firstname : First of the user} 
                            {lastname : Last name of the user} 
                            {rank=0 : Wanted Rank 0..2}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Helper for create an account';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $email = $this->argument('email');
        $password = $this->argument('password');
        $firstname = $this->argument('firstname');
        $lastname = $this->argument('lastname');
        $rank = $this->argument('rank');
        
        $params = array( 
                            'email' => $email, 
                            'password' => $password, 
                            'firstname' => $firstname, 
                            'lastname' => $lastname, 
                            'rank' => $rank
                        );
                        
        $rules = array(
                        'email' => 'required|email|unique:account,email',
                        'password' => 'required|min:4',
                        'firstname' => 'required|string',
                        'lastname' => 'required|string',
                        'rank' => 'required|integer|min:0|max:2'
                    );    

        $v = Validator::make($params, $rules);

        if ($v->fails()) 
        {
            
            foreach ($v->messages()->getMessages() as $field_name => $messages)
            {
                foreach($messages as $key => $message)
                {
                     $this->error($field_name.' : '.$message);
                }
            }
        }
        else
        {
            $firstname = ucfirst($firstname);
            $lastname = strtoupper($lastname);
            
            $account = new Account();
            $account->firstname = $firstname;
            $account->lastname = $lastname;
            $account->sha1_pass = sha1(strtoupper($email).':'.$password);
            $account->email = $email;
            $account->rank = $rank;
            $account->save();
            
            $this->info('Account '.$email.':'.$password.' is create !');
        }
    }
}

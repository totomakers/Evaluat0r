<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Session extends Model
{
    public $timestamps = false;

    // Basic configuration
    // $connection is the database name in config/database.php
    // $table is the table name used
    // $primaryKey is the table primary key
    protected $connection = 'evaluat0r';
    protected $table = 'session';
    
    //Added virtual field
    protected $appends = array('question_count', 'candidate_count');
    
    //Date
    protected $dateFormat = 'Y-m-d';
    protected $dates = ['start_date', 'end_date'];
    
    //Relationships
    public function questions()
    {
        return $this->belongsToMany('App\Models\Question', 'session_question', 'session_id', 'question_id');
    }
    
    public function candidates()
    {
         return $this->belongsToMany('App\Models\Account', 'session_candidate', 'session_id', 'account_id')->withPivot('created_at');
    }

    //Virtual field
    public function getQuestionCountAttribute()
    {
       return $this->questions()->count();
    }
    
    public function getCandidateCountAttribute()
    {
        return $this->candidates()->count();
    }
}
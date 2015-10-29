<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Evaluation extends Model
{
    public $timestamps = false;
    
    // Basic configuration
    // $connection is the database name in config/database.php
    // $table is the table name used
    // $primaryKey is the table primary key
    protected $connection = 'evaluat0r';
    protected $table = 'evaluation';
    protected $primaryKey = 'id';
    
    protected $dates = ['start'];
    
     public function session()
    {
        return $this->hasOne('App\Models\Session', 'id', 'session_id');
    }
    
    public function questions()
    { 
        return $this->belongsToMany('App\Models\Question', 'evaluation_question', 'evaluation_id', 'question_id')->withPivot('mark');
    }
    
    public function answers()
    {
        return $this->belongsToMany('App\Models\Answer', 'evaluation_answer', 'evaluation_id', 'answer_id');
    }
    
    //Added virtual field
    protected $appends = array('question_answer_count');
    
     //Virtual field
    public function getQuestionAnswerCountAttribute()
    {
       return $this->questions()->count();
    }
    
   
    
    
}
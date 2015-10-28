<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Question extends Model
{
    public $timestamps = false;

    // Basic configuration
    // $connection is the database name in config/database.php
    // $table is the table name used
    // $primaryKey is the table primary key
    protected $connection = 'evaluat0r';
    protected $table = 'question';
      
    public function theme()
    {
         return $this->belongsTo('App\Models\Theme', 'theme_id');
    }
    
    public function answers()
    {
        return $this->hasMany('App\Models\Answer');
    }
}
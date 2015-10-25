<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Template extends Model
{
    public $timestamps = false;

    // Basic configuration
    // $connection is the database name in config/database.php
    // $table is the table name used
    // $primaryKey is the table primary key
    protected $connection = 'evaluat0r';
    protected $table = 'template';
    //protected $primaryKey = 'id';
    
    public function themes()
    {
        return $this->belongsToMany('App\Models\Theme', 'template_theme', 'template_id', 'theme_id')->withPivot('question_count');
    }
}
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Evaluation extends Model
{
    // Basic configuration
    // $connection is the database name in config/database.php
    // $table is the table name used
    // $primaryKey is the table primary key
    protected $connection = 'evaluat0r';
    protected $table = 'evaluation';
    //protected $primaryKey = 'id';
}
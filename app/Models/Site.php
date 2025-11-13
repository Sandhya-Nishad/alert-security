<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Site extends Model
{
    protected $fillable = ['zone_id', 'name'];

    public function zone()
    {
        return $this->belongsTo(Zone::class);
    }
}

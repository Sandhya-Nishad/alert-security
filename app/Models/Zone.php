<?php

namespace App\Models;

use App\Traits\GlobalStatus;
use Illuminate\Database\Eloquent\Model;

class Zone extends Model
{
    use GlobalStatus;

    protected $fillable = [
        'name',
        'address',
        'status'
    ];

    public function sites()
    {
        return $this->hasMany(\App\Models\Site::class);
    }
}

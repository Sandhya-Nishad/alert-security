<?php

namespace App\Models;

use App\Traits\ActionTakenBy;
use Illuminate\Database\Eloquent\Model;

class Purchase extends Model
{
    use ActionTakenBy;

    protected $fillable = [
        'supplier_id',
        'invoice_no',
        'warehouse_id',
        'purchase_date',
        'total_price',
        'discount_amount',
        'igst_amount',
        'cgst_amount',
        'sgst_amount',
        'gst_type',
        'payable_amount',
        'paid_amount',
        'due_amount',
        'note',
        'return_status',
    ];

    public function supplier()
    {
        return $this->belongsTo(Supplier::class);
    }

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class);
    }

    public function purchaseDetails()
    {
        return $this->hasMany(PurchaseDetails::class);
    }

    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    public function purchaseReturn()
    {
        return $this->hasOne(PurchaseReturn::class);
    }
}

<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('purchases', function (Blueprint $table) {
            $table->decimal('igst_amount', 28, 8)->default(0)->after('discount_amount')->nullable();
            $table->decimal('cgst_amount', 28, 8)->default(0)->after('igst_amount')->nullable();
            $table->decimal('sgst_amount', 28, 8)->default(0)->after('cgst_amount')->nullable();
            $table->enum('gst_type', ['none', 'igst', 'cgst_sgst'])->default('none')->after('sgst_amount')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('purchases', function (Blueprint $table) {
            $table->dropColumn(['igst_amount', 'cgst_amount', 'sgst_amount', 'gst_type']);
        });
    }
};

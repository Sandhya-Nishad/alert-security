<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddZoneidPhotoIdnumberToCustomers extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('customers', function (Blueprint $table) {
            if (!Schema::hasColumn('customers', 'zone_id')) {
                $table->unsignedBigInteger('zone_id')->nullable()->after('address');
            }
            if (!Schema::hasColumn('customers', 'id_number')) {
                $table->string('id_number', 100)->nullable()->after('zone_id');
            }
            if (!Schema::hasColumn('customers', 'photo')) {
                $table->string('photo')->nullable()->after('id_number');
            }
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('customers', function (Blueprint $table) {
            if (Schema::hasColumn('customers', 'zone_id')) {
                $table->dropColumn('zone_id');
            }
            if (Schema::hasColumn('customers', 'id_number')) {
                $table->dropColumn('id_number');
            }
            if (Schema::hasColumn('customers', 'photo')) {
                $table->dropColumn('photo');
            }
        });
    }
}

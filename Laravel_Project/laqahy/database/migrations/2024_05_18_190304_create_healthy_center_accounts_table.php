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
        Schema::create('healthy_center_accounts', function (Blueprint $table) {
            $table->id();
            $table->foreignId('healthy_center_id')->constrained('healthy_centers');
            $table->String('device_name');
            $table->String('MAC_address');
            $table->dateTime('join_date');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('healthy_center_accounts');
    }
};

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
        Schema::create('healthy_centers', function (Blueprint $table) {
            $table->id();
            $table->String('healthy_center_name');
            $table->String('healthy_center_address');
            $table->String('healthy_center_phone');
            $table->String('healthy_center_installation_cod');
            $table->foreignId('directorate_id')->constrained('directorates');
            $table->foreignId('cities_id')->constrained('cities');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('healthy_centers');
    }
};

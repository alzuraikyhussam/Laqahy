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
        Schema::create('mother_datas', function (Blueprint $table) {
            $table->id();
            $table->string('mother_name');
            $table->string('mother_phone');
            $table->date('mother_birthdate');
            $table->string('mother_village');
            $table->string('mother_password');
            $table->foreignId('cities_id')->constrained('cities');
            $table->foreignId('directorates_id')->constrained('directorates');
            $table->foreignId('healthy_centers_id')->constrained('healthy_centers');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('mother_datas');
    }
};

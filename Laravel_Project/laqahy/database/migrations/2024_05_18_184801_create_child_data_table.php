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
        Schema::create('child_data', function (Blueprint $table) {
            $table->id();
            $table->String('child_data_name');
            $table->foreignId('mother_data_id')->constrained('mother_data')->onUpdate('cascade');
            $table->String('child_data_birthplace');
            $table->date('child_data_birthDate');
            $table->foreignId('gender_id')->constrained('genders')->onUpdate('cascade');
            $table->text('fcm_token')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('child_data');
    }
};

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
        Schema::create('mother_data', function (Blueprint $table) {
            $table->id();
            $table->string('mother_name');
            $table->string('mother_phone');
            $table->string('mother_identity_num')->unique();
            $table->date('mother_birthDate');
            $table->string('mother_village');
            $table->string('mother_identity_num')->unique();
            $table->string('mother_password');
            $table->foreignId('cities_id')->constrained('cities')->onUpdate('cascade');
            $table->foreignId('directorate_id')->constrained('directorates')->onUpdate('cascade');
            $table->foreignId('healthy_center_id')->constrained('healthy_centers')->onUpdate('cascade');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('mother_data');
    }
};

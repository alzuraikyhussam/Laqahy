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
        Schema::create('child_datas', function (Blueprint $table) {
            $table->id();
            $table->String('child_data_name');
            $table->foreignId('mother_datas_id')->constrained('mother_datas');
            $table->String('child_data_birthplace');
            $table->date('child_data_birthdate');
            $table->foreignId('genders_id')->constrained('genders');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('child_datas');
    }
};

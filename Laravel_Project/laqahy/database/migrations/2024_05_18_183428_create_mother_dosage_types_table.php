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
        Schema::create('mother_dosage_types', function (Blueprint $table) {
            $table->id();
            $table->string('mother_dosage_type');
            $table->foreignId('dosage_level_id')->constrained('dosage_levels')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('mother_dosage_types');
    }
};

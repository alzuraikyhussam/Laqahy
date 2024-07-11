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
        Schema::create('vaccines_with_dosages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('vaccine_type_id')->constrained('vaccine_types')->onUpdate('cascade');
            $table->foreignId('child_dosage_type_id')->constrained('child_dosage_types')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('vaccines_with_dosages');
    }
};

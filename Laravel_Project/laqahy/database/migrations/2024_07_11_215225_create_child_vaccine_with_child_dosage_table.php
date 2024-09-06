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
        Schema::create('child_vaccine_with_child_dosage', function (Blueprint $table) {
            $table->id();
            $table->foreignId('child_vaccine_id')->constrained('child_vaccines')->onUpdate('cascade');
            $table->foreignId('child_dosage_type_id')->constrained('child_dosage_types')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('child_vaccine_with_child_dosage');
    }
};

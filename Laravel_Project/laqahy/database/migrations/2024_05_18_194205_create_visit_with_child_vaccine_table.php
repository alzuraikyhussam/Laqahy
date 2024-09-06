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
        Schema::create('visit_with_child_vaccine', function (Blueprint $table) {
            $table->id();
            $table->foreignId('visit_type_id')->constrained('visit_types')->onUpdate('cascade');
            $table->foreignId('child_vaccine_id')->constrained('child_vaccines')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('visit_with_child_vaccine');
    }
};

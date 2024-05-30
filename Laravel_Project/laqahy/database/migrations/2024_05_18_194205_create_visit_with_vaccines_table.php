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
        Schema::create('visit_with_vaccines', function (Blueprint $table) {
            $table->id();
            $table->foreignId('visit_type_id')->constrained('visit_types');
            $table->foreignId('vaccine_type_id')->constrained('vaccine_types');

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('visit_with_vaccines');
    }
};

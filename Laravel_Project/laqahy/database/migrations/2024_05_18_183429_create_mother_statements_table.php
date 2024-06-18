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
        Schema::create('mother_statements', function (Blueprint $table) {
            $table->id();
            $table->foreignId('mother_data_id')->constrained('mother_datas')->onUpdate('cascade');
            $table->foreignId('healthy_center_id')->constrained('healthy_centers')->onUpdate('cascade');
            $table->foreignId('user_id')->constrained('users')->onUpdate('cascade');
            $table->date('date_taking_dose');
            $table->date('return_date');
            $table->foreignId('dosage_type_id')->constrained('dosage_types')->onUpdate('cascade');
            $table->foreignId('dosage_level_id')->constrained('dosage_levels')->onUpdate('cascade');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('mother_statements');
    }
};

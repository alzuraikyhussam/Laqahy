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
            $table->foreignId('mother_data_id')->constrained('mother_data')->onUpdate('cascade');
            $table->foreignId('healthy_center_account_id')->constrained('healthy_center_accounts')->onUpdate('cascade');
            $table->foreignId('user_id')->constrained('users')->onUpdate('cascade');
            $table->dateTime('date_taking_dose')->useCurrent();
            $table->date('return_date');
            $table->foreignId('mother_vaccine_id')->constrained('mother_vaccines')->onUpdate('cascade');
            $table->foreignId('mother_dosage_type_id')->constrained('mother_dosage_types')->onUpdate('cascade');
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

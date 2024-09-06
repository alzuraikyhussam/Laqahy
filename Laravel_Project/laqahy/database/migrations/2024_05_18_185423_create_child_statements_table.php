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
        Schema::create('child_statements', function (Blueprint $table) {
            $table->id();
            $table->foreignId('child_data_id')->constrained('child_data')->onUpdate('cascade');
            $table->foreignId('healthy_center_account_id')->constrained('healthy_center_accounts')->onUpdate('cascade');
            $table->foreignId('user_id')->constrained('users')->onUpdate('cascade');
            $table->dateTime('date_taking_dose')->useCurrent();
            $table->date('return_date');
            $table->foreignId('visit_type_id')->constrained('visit_types')->onUpdate('cascade');
            $table->foreignId('child_vaccine_id')->constrained('child_vaccines')->onUpdate('cascade');
            $table->foreignId('child_dosage_type_id')->constrained('child_dosage_types')->onUpdate('cascade');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('child_statements');
    }
};

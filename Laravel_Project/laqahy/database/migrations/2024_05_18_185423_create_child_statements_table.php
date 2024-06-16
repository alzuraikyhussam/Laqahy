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
            $table->foreignId('child_data_id')->constrained('child_datas');
            $table->foreignId('healthy_center_id')->constrained('healthy_centers');
            $table->foreignId('user_id')->constrained('users');
            $table->date('date_taking_dose');
            $table->date('return_date');
            $table->foreignId('visit_type_id')->constrained('visit_types');
            $table->foreignId('vaccine_type_id')->constrained('vaccine_types');
            $table->foreignId('dosage_type_id')->constrained('dosage_types');
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

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
            $table->foreignId('child_datas_id')->constrained('child_datas');
            $table->foreignId('healthy_centers_id')->constrained('healthy_centers');
            $table->String('health_employee_name');
            $table->date('date_taking_dose');
            $table->date('return_date');
            $table->foreignId('visit_types_id')->constrained('visit_types');
            $table->foreignId('vaccine_types_id')->constrained('vaccine_types');
            $table->foreignId('dosage_types_id')->constrained('dosage_types');
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

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
        Schema::create('vaccine_stock_statements', function (Blueprint $table) {
            $table->id();
            $table->morphs('vaccine_type');
            $table->integer('quantity');
            $table->foreignId('office_type_id')->constrained('office_types')->onUpdate('cascade');
            $table->morphs('office_name');
            $table->foreignId('donor_id')->nullable()->constrained('donors')->onUpdate('cascade');
            $table->dateTime('date')->useCurrent();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('vaccine_stock_statements');
    }
};

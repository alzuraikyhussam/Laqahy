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
        Schema::create('offices_stock_vaccines', function (Blueprint $table) {
            $table->id();
            $table->foreignId('office_id')->constrained('offices')->onUpdate('cascade');
            $table->foreignId('vaccine_type_id')->constrained('vaccine_types')->onUpdate('cascade');
            $table->integer('quantity');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('offices_stock_vaccines');
    }
};

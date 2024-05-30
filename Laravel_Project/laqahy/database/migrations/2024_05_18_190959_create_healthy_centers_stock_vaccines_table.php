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
        Schema::create('healthy_centers_stock_vaccines', function (Blueprint $table) {
            $table->id();
            $table->foreignId('healthy_center_id')->constrained('healthy_centers');
            $table->foreignId('vaccine_type_id')->constrained('vaccine_types');
            $table->integer('basic_quantity');
            $table->integer('remaining_quantity');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('healthy_centers_stock_vaccines');
    }
};

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
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->foreignId('vaccine_type_id')->constrained('vaccine_types');
            $table->foreignId('healthy_center_id')->constrained('healthy_centers');
            $table->date('order_date');
            $table->integer('quantity');
            $table->date('delivery_date');
            $table->String('healthy_center_note_date');
            $table->String('ministry_note_date');
            $table->foreignId('order_state_id')->constrained('order_states');
            $table->date('date_deleted_from_healthy_center');
            $table->date('date_deleted_from_ministry');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};

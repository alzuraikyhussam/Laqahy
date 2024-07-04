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
        Schema::create('offices_orders', function (Blueprint $table) {
            $table->id();
            $table->foreignId('vaccine_type_id')->constrained('vaccine_types')->onUpdate('cascade');
            $table->foreignId('office_id')->constrained('offices')->onUpdate('cascade');
            $table->dateTime('order_date')->useCurrent();
            $table->integer('quantity');
            $table->dateTime('delivery_date')->nullable();
            $table->text('office_note_data')->nullable();
            $table->text('ministry_note_data')->nullable();
            $table->foreignId('order_state_id')->constrained('order_states')->onUpdate('cascade');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('offices_orders');
    }
};

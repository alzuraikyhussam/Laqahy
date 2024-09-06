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
            $table->morphs('vaccine_type');
            $table->foreignId('office_type_id')->constrained('office_types')->onUpdate('cascade');
            $table->morphs('office_name');
            $table->integer('order_quantity');
            $table->dateTime('order_request_date')->useCurrent();
            $table->dateTime('order_delivery_date')->nullable();
            $table->text('order_sender_note')->nullable();
            $table->text('order_receiver_note')->nullable();
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
        Schema::dropIfExists('orders');
    }
};

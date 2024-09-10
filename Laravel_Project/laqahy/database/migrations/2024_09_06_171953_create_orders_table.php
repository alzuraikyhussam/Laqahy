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
            $table->unsignedBigInteger('vaccine_type_id');
            $table->enum('vaccine_category', ['لقاحات الام', 'لقاحات الطفل']);
            $table->foreignId('office_type_id')->constrained('office_types')->onUpdate('cascade');
            $table->unsignedBigInteger('office_account_id');
            $table->integer('order_quantity');
            $table->dateTime('order_request_date')->useCurrent();
            $table->dateTime('order_delivery_date')->nullable();
            $table->text('order_sender_note')->nullable();
            $table->text('order_receiver_note')->nullable();
            $table->foreignId('order_state_id')->constrained('order_states')->onUpdate('cascade');
            $table->timestamps();
            $table->softDeletes();

            $table->foreign('vaccine_type_id', 'mother_vaccine_foreign')->references('id')->on('mother_vaccines')->onUpdate('cascade');
            $table->foreign('vaccine_type_id', 'child_vaccine_foreign')->references('id')->on('child_vaccines')->onUpdate('cascade');

            $table->foreign('office_account_id', 'city_office_account_foreign3')->references('id')->on('city_office_accounts')->onUpdate('cascade');
            $table->foreign('office_account_id', 'directorate_office_account_foreign3')->references('id')->on('directorate_office_accounts')->onUpdate('cascade');
            $table->foreign('office_account_id', 'healthy_centers_account_foreign3')->references('id')->on('healthy_center_accounts')->onUpdate('cascade');
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

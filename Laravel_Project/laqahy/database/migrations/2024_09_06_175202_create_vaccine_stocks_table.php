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
        Schema::create('vaccine_stock', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('vaccine_type_id');
            $table->integer('vaccine_quantity');
            $table->foreignId('office_type_id')->constrained('office_types')->onUpdate('cascade');
            $table->enum('vaccine_category', ['لقاحات الام', 'لقاحات الطفل']);
            $table->unsignedBigInteger('office_account_id');

            $table->foreign('vaccine_type_id', 'mother_vaccine_foreign3')->references('id')->on('mother_vaccines')->onUpdate('cascade');
            $table->foreign('vaccine_type_id', 'child_vaccine_foreign3')->references('id')->on('child_vaccines')->onUpdate('cascade');

            $table->foreign('office_account_id', 'city_office_account_foreign5')->references('id')->on('city_office_accounts')->onUpdate('cascade');
            $table->foreign('office_account_id', 'directorate_office_account_foreign5')->references('id')->on('directorate_office_accounts')->onUpdate('cascade');
            $table->foreign('office_account_id', 'healthy_centers_account_foreign5')->references('id')->on('healthy_center_accounts')->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('vaccine_stock');
    }
};

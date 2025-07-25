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
            $table->unsignedBigInteger('vaccine_type_id');
            $table->enum('vaccine_category', ['لقاحات الام', 'لقاحات الطفل']);
            $table->integer('vaccine_statement_quantity');
            $table->foreignId('office_type_id')->constrained('office_types')->onUpdate('cascade');
            $table->unsignedBigInteger('office_account_id');
            $table->foreignId('donor_id')->nullable()->constrained('donors')->onUpdate('cascade');
            $table->dateTime('vaccine_statement_date')->useCurrent();
            $table->softDeletes();

            $table->foreign('vaccine_type_id', 'mother_vaccine_foreign2')->references('id')->on('mother_vaccines')->onUpdate('cascade');
            $table->foreign('vaccine_type_id', 'child_vaccine_foreign2')->references('id')->on('child_vaccines')->onUpdate('cascade');

            $table->foreign('office_account_id', 'city_office_account_foreign4')->references('id')->on('city_office_accounts')->onUpdate('cascade');
            $table->foreign('office_account_id', 'directorate_office_account_foreign4')->references('id')->on('directorate_office_accounts')->onUpdate('cascade');
            $table->foreign('office_account_id', 'healthy_centers_account_foreign4')->references('id')->on('healthy_center_accounts')->onUpdate('cascade');
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

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
        Schema::create('city_office_accounts', function (Blueprint $table) {
            $table->id();
            $table->string('city_office_account_name');
            $table->string('setup_code')->nullable();
            $table->string('city_office_account_phone')->nullable();
            $table->foreignId('city_id')->constrained('cities')->onUpdate('cascade');
            $table->foreignId('office_type_id')->constrained('office_types')->onUpdate('cascade');
            $table->text('city_office_account_address')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('city_office_accounts');
    }
};

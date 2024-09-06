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
        Schema::create('directorate_office_accounts', function (Blueprint $table) {
            $table->id();
            $table->string('directorate_office_account_name');
            $table->string('setup_code')->nullable();
            $table->string('directorate_office_account_phone')->nullable();
            $table->foreignId('directorate_id')->constrained('directorates')->onUpdate('cascade');
            $table->foreignId('city_office_account_id')->constrained('city_office_accounts')->onUpdate('cascade');
            $table->text('directorate_office_account_address')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('directorate_office_accounts');
    }
};

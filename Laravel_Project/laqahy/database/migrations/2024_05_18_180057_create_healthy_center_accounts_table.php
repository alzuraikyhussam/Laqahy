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
        Schema::create('healthy_center_accounts', function (Blueprint $table) {
            $table->id();
            $table->string('healthy_center_account_name');
            $table->string('setup_code')->nullable();
            $table->string('healthy_center_account_phone');
            $table->text('healthy_center_account_address');
            $table->foreignId('directorate_office_account_id')->constrained('directorate_office_accounts')->onUpdate('cascade');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('healthy_center_accounts');
    }
};

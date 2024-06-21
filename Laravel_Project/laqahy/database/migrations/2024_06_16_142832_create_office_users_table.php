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
        Schema::create('office_users', function (Blueprint $table) {
            $table->id();
            $table->String('user_name');
            $table->String('user_phone');
            $table->text('user_address');
            $table->date('user_birthDate');
            $table->String('user_account_name');
            $table->String('user_account_password');
            $table->foreignId('gender_id')->constrained('genders')->onUpdate('cascade');
            $table->foreignId('permission_type_id')->constrained('permission_types')->onUpdate('cascade');
            $table->foreignId('office_id')->constrained('offices')->onUpdate('cascade');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('office_users');
    }
};

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
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('user_name');
            $table->string('user_phone');
            $table->text('user_address');
            $table->date('user_birthDate');
            $table->string('user_account_name');
            $table->string('user_account_password');
            $table->foreignId('gender_id')->constrained('genders')->onUpdate('cascade');
            $table->foreignId('permission_type_id')->constrained('permission_types')->onUpdate('cascade');
            $table->foreignId('office_type_id')->constrained('office_types')->onUpdate('cascade');
            $table->morphs('office_name');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};

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
            $table->String('user_name');
            $table->String('user_phone');
            $table->String('user_address');
            $table->date('user_birthdate');
            $table->String('user_account_name');
            $table->String('user_account_password');
            $table->foreignId('genders_id')->constrained('genders');
            $table->foreignId('permission_types_id')->constrained('permission_types');
            $table->foreignId('healthy_centers_id')->constrained('healthy_centers');
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

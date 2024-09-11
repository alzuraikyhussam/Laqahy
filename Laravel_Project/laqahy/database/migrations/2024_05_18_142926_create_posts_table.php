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
        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->string('post_title');
            $table->longText('post_description');
            $table->string('post_image');
            $table->foreignId('office_type_id')->constrained('office_types')->onUpdate('cascade');
            $table->foreignId('city_office_account_id')->constrained('city_office_accounts')->onUpdate('cascade');
            $table->dateTime('post_publish_date')->useCurrent();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('posts');
    }
};

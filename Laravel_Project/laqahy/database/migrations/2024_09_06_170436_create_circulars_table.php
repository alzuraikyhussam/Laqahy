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
        Schema::create('circulars', function (Blueprint $table) {
            $table->id();
            $table->string('circular_title');
            $table->longText('circular_description');
            $table->dateTime('circular_date')->useCurrent();
            $table->foreignId('send_type_id')->constrained('send_types')->onUpdate('cascade');
            $table->foreignId('office_type_id')->constrained('office_types')->onUpdate('cascade');
            $table->morphs('sen_office_name');
            $table->morphs('rec_office_name');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('circulars');
    }
};

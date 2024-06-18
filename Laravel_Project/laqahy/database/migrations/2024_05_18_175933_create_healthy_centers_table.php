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
        Schema::create('healthy_centers', function (Blueprint $table) {
            $table->id();
            $table->String('healthy_center_name');
            $table->text('healthy_center_address');
            $table->String('healthy_center_phone');
            $table->String('healthy_center_installation_code')->nullable();
            $table->foreignId('directorate_id')->constrained('directorates')->onUpdate('cascade');
            $table->foreignId('cities_id')->constrained('cities')->onUpdate('cascade');
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
        Schema::dropIfExists('healthy_centers');
    }
};

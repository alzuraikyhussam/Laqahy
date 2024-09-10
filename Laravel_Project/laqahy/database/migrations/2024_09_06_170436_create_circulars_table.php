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
            $table->unsignedBigInteger('sen_office_id');
            $table->unsignedBigInteger('rec_office_id')->nullable();

            $table->foreign('sen_office_id', 'city_office_account_foreign1')->references('id')->on('city_office_accounts')->onUpdate('cascade');
            $table->foreign('sen_office_id', 'directorate_office_account_foreign1')->references('id')->on('directorate_office_accounts')->onUpdate('cascade');
            $table->foreign('rec_office_id', 'city_office_account_foreign2')->references('id')->on('city_office_accounts')->onUpdate('cascade');
            $table->foreign('rec_office_id', 'directorate_office_account_foreign2')->references('id')->on('directorate_office_accounts')->onUpdate('cascade');

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

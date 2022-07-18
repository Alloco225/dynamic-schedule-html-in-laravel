<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppEstimationQuestionsTable extends Migration
{

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_estimation_questions', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedBigInteger('app_estimation_type_id')->nullable()->index();
            $table->string('title')->nullable();
            $table->string('title_fr')->nullable();
            $table->string('name')->nullable();
            $table->string('type')->default("checkbox");
            $table->integer('order')->nullable();
            $table->string('image')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('app_estimation_questions');
    }
}

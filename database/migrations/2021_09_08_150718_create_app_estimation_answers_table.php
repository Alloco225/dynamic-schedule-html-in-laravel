<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAppEstimationAnswersTable extends Migration
{

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('app_estimation_answers', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedBigInteger('app_estimation_question_id')->nullable()->index();
            $table->string('title')->nullable();
            $table->string('title_fr')->nullable();
            $table->string('description')->nullable();
            $table->string('image')->nullable();
            $table->string('value')->nullable();
            $table->string('content')->default(1);
            $table->string('content_type')->default("days");
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
        Schema::drop('app_estimation_answers');
    }
}

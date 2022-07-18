<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateClientProjectFeatureTasksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('client_project_feature_tasks', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('data_feature_task_id')->index()->nullable();
            $table->integer('order')->nullable();
            $table->boolean('is_ongoing')->nullable();
            $table->boolean('is_done')->nullable();
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
        Schema::dropIfExists('client_project_feature_tasks');
    }
}

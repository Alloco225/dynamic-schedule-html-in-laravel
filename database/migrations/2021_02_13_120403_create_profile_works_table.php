<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProfileWorksTable extends Migration
{

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('profile_works', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedBigInteger('profile_id')->nullable()->default(1);
            $table->string('label')->nullable();
            $table->text('thumbnail')->nullable();
            $table->text('logo')->nullable();
            $table->text('image')->nullable();
            $table->text('cover')->nullable();
            $table->text('description')->nullable();
            $table->text('url')->nullable();
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
        Schema::drop('profile_works');
    }
}

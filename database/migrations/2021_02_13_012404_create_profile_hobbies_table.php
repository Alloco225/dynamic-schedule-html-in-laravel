<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProfileHobbiesTable extends Migration
{

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('profile_hobbies', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedBigInteger('profile_id')->nullable()->default(1);
            $table->text('html_icon')->nullable();
            $table->text('html_image')->nullable();
            $table->string('label')->nullable();
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
        Schema::drop('profile_hobbies');
    }
}

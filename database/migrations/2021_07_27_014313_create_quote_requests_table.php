<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateQuoteRequestsTable extends Migration
{

    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('quote_requests', function (Blueprint $table) {
            $table->increments('id');
            $table->string('full_name');
            $table->string('email');
            $table->string('company_name');
            $table->text('company_description');
            $table->string('company_link');
            $table->text('reason_for_rebuild');
            $table->text('competitor_links');
            $table->text('logo_url');
            $table->string('app_size');
            $table->string('ui_level');
            $table->boolean('user_account_email');
            $table->boolean('user_account_phone');
            $table->boolean('user_account_facebook');
            $table->boolean('user_account_twitter');
            $table->boolean('user_account_google');
            $table->boolean('user_account_linkedin');
            $table->boolean('user_account_github');
            $table->boolean('user_account_email_invitation');
            $table->boolean('user_account_multitenant');
            $table->boolean('user_account_subdomain');
            $table->boolean('user_account_custom_domain');
            $table->boolean('ugc_dashboard');
            $table->boolean('ugc_activity_feed');
            $table->boolean('ugc_file_upload');
            $table->boolean('ugc_user_profile');
            $table->boolean('ugc_transactional_emails');
            $table->boolean('ugc_tags');
            $table->boolean('ugc_ratings_or_ratings');
            $table->boolean('ugc_media_processing');
            $table->boolean('ugc_free_text_searching');
            $table->boolean('date_calendaring');
            $table->boolean('map_geolocation');
            $table->boolean('custom_map');
            $table->boolean('bookings');
            $table->boolean('in_app_messaging');
            $table->boolean('forums_and_commenting');
            $table->boolean('social_sharing');
            $table->boolean('subscription_plans');
            $table->boolean('payment_processing');
            $table->boolean('shoping_cart');
            $table->boolean('user_marketplace');
            $table->boolean('product_management');
            $table->boolean('cms');
            $table->boolean('user_admin_pages');
            $table->boolean('content_moderation');
            $table->boolean('intercom_or_chatbot');
            $table->boolean('usage_analytics');
            $table->boolean('crash_reporting');
            $table->boolean('performance_monitoring');
            $table->boolean('multilingual_support');
            $table->boolean('third_party_apis');
            $table->boolean('api');
            $table->boolean('sms_messaging');
            $table->boolean('blog');
            $table->boolean('user_testimonials');
            $table->boolean('ssl_certificate');
            $table->boolean('dos_protection');
            $table->boolean('two_factor_auth');
            $table->boolean('app_icon_design');
            $table->boolean('cloud_syncing');
            $table->boolean('barcode_qrcode');
            $table->boolean('notifications');
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
        Schema::drop('quote_requests');
    }
}

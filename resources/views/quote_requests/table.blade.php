<div class="table-responsive">
    <table class="table" id="quoteRequests-table">
        <thead>
            <tr>
                <th>Full Name</th>
        <th>Email</th>
        <th>Company Name</th>
        <th>Company Description</th>
        <th>Company Link</th>
        <th>Reason For Rebuild</th>
        <th>Competitor Links</th>
        <th>Logo Url</th>
        <th>App Size</th>
        <th>Ui Level</th>
        <th>User Account Email</th>
        <th>User Account Phone</th>
        <th>User Account Facebook</th>
        <th>User Account Twitter</th>
        <th>User Account Google</th>
        <th>User Account Linkedin</th>
        <th>User Account Github</th>
        <th>User Account Email Invitation</th>
        <th>User Account Multitenant</th>
        <th>User Account Subdomain</th>
        <th>User Account Custom Domain</th>
        <th>Ugc Dashboard</th>
        <th>Ugc Activity Feed</th>
        <th>Ugc File Upload</th>
        <th>Ugc User Profile</th>
        <th>Ugc Transactional Emails</th>
        <th>Ugc Tags</th>
        <th>Ugc Ratings Or Ratings</th>
        <th>Ugc Media Processing</th>
        <th>Ugc Free Text Searching</th>
        <th>Date Calendaring</th>
        <th>Map Geolocation</th>
        <th>Custom Map</th>
        <th>Bookings</th>
        <th>In App Messaging</th>
        <th>Forums And Commenting</th>
        <th>Social Sharing</th>
        <th>Subscription Plans</th>
        <th>Payment Processing</th>
        <th>Shoping Cart</th>
        <th>User Marketplace</th>
        <th>Product Management</th>
        <th>Cms</th>
        <th>User Admin Pages</th>
        <th>Content Moderation</th>
        <th>Intercom Or Chatbot</th>
        <th>Usage Analytics</th>
        <th>Crash Reporting</th>
        <th>Performance Monitoring</th>
        <th>Multilingual Support</th>
        <th>Third Party Apis</th>
        <th>Api</th>
        <th>Sms Messaging</th>
        <th>Blog</th>
        <th>User Testimonials</th>
        <th>Ssl Certificate</th>
        <th>Dos Protection</th>
        <th>Two Factor Auth</th>
        <th>App Icon Design</th>
        <th>Cloud Syncing</th>
        <th>Barcode Qrcode</th>
        <th>Notifications</th>
                <th colspan="3">Action</th>
            </tr>
        </thead>
        <tbody>
        @foreach($quoteRequests as $quoteRequest)
            <tr>
                <td>{{ $quoteRequest->full_name }}</td>
            <td>{{ $quoteRequest->email }}</td>
            <td>{{ $quoteRequest->company_name }}</td>
            <td>{{ $quoteRequest->company_description }}</td>
            <td>{{ $quoteRequest->company_link }}</td>
            <td>{{ $quoteRequest->reason_for_rebuild }}</td>
            <td>{{ $quoteRequest->competitor_links }}</td>
            <td>{{ $quoteRequest->logo_url }}</td>
            <td>{{ $quoteRequest->app_size }}</td>
            <td>{{ $quoteRequest->ui_level }}</td>
            <td>{{ $quoteRequest->user_account_email }}</td>
            <td>{{ $quoteRequest->user_account_phone }}</td>
            <td>{{ $quoteRequest->user_account_facebook }}</td>
            <td>{{ $quoteRequest->user_account_twitter }}</td>
            <td>{{ $quoteRequest->user_account_google }}</td>
            <td>{{ $quoteRequest->user_account_linkedin }}</td>
            <td>{{ $quoteRequest->user_account_github }}</td>
            <td>{{ $quoteRequest->user_account_email_invitation }}</td>
            <td>{{ $quoteRequest->user_account_multitenant }}</td>
            <td>{{ $quoteRequest->user_account_subdomain }}</td>
            <td>{{ $quoteRequest->user_account_custom_domain }}</td>
            <td>{{ $quoteRequest->ugc_dashboard }}</td>
            <td>{{ $quoteRequest->ugc_activity_feed }}</td>
            <td>{{ $quoteRequest->ugc_file_upload }}</td>
            <td>{{ $quoteRequest->ugc_user_profile }}</td>
            <td>{{ $quoteRequest->ugc_transactional_emails }}</td>
            <td>{{ $quoteRequest->ugc_tags }}</td>
            <td>{{ $quoteRequest->ugc_ratings_or_ratings }}</td>
            <td>{{ $quoteRequest->ugc_media_processing }}</td>
            <td>{{ $quoteRequest->ugc_free_text_searching }}</td>
            <td>{{ $quoteRequest->date_calendaring }}</td>
            <td>{{ $quoteRequest->map_geolocation }}</td>
            <td>{{ $quoteRequest->custom_map }}</td>
            <td>{{ $quoteRequest->bookings }}</td>
            <td>{{ $quoteRequest->in_app_messaging }}</td>
            <td>{{ $quoteRequest->forums_and_commenting }}</td>
            <td>{{ $quoteRequest->social_sharing }}</td>
            <td>{{ $quoteRequest->subscription_plans }}</td>
            <td>{{ $quoteRequest->payment_processing }}</td>
            <td>{{ $quoteRequest->shoping_cart }}</td>
            <td>{{ $quoteRequest->user_marketplace }}</td>
            <td>{{ $quoteRequest->product_management }}</td>
            <td>{{ $quoteRequest->cms }}</td>
            <td>{{ $quoteRequest->user_admin_pages }}</td>
            <td>{{ $quoteRequest->content_moderation }}</td>
            <td>{{ $quoteRequest->intercom_or_chatbot }}</td>
            <td>{{ $quoteRequest->usage_analytics }}</td>
            <td>{{ $quoteRequest->crash_reporting }}</td>
            <td>{{ $quoteRequest->performance_monitoring }}</td>
            <td>{{ $quoteRequest->multilingual_support }}</td>
            <td>{{ $quoteRequest->third_party_apis }}</td>
            <td>{{ $quoteRequest->api }}</td>
            <td>{{ $quoteRequest->sms_messaging }}</td>
            <td>{{ $quoteRequest->blog }}</td>
            <td>{{ $quoteRequest->user_testimonials }}</td>
            <td>{{ $quoteRequest->ssl_certificate }}</td>
            <td>{{ $quoteRequest->dos_protection }}</td>
            <td>{{ $quoteRequest->two_factor_auth }}</td>
            <td>{{ $quoteRequest->app_icon_design }}</td>
            <td>{{ $quoteRequest->cloud_syncing }}</td>
            <td>{{ $quoteRequest->barcode_qrcode }}</td>
            <td>{{ $quoteRequest->notifications }}</td>
                <td width="120">
                    {!! Form::open(['route' => ['quoteRequests.destroy', $quoteRequest->id], 'method' => 'delete']) !!}
                    <div class='btn-group'>
                        <a href="{{ route('quoteRequests.show', [$quoteRequest->id]) }}" class='btn btn-default btn-xs'>
                            <i class="far fa-eye"></i>
                        </a>
                        <a href="{{ route('quoteRequests.edit', [$quoteRequest->id]) }}" class='btn btn-default btn-xs'>
                            <i class="far fa-edit"></i>
                        </a>
                        {!! Form::button('<i class="far fa-trash-alt"></i>', ['type' => 'submit', 'class' => 'btn btn-danger btn-xs', 'onclick' => "return confirm('Are you sure?')"]) !!}
                    </div>
                    {!! Form::close() !!}
                </td>
            </tr>
        @endforeach
        </tbody>
    </table>
</div>

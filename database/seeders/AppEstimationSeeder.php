<?php

namespace Database\Seeders;

use App\Models\AppEstimationAnswer;
use App\Models\Settings;
use App\Models\AppEstimationQuestion;
use App\Models\AppEstimationType;
use Illuminate\Database\Seeder;

class AppEstimationSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //
        $app_types = [
            [
                'title' => "Web",
                'description' => "A web app or a backend to a mobile app",
                'value' => "web",
                'platform' => "web",
                'image' => "",
            ],
            [
                'title' => "iOS",
                'description' => "An iPhone/iPad app (excluding backend)",
                'value' => "ios",
                'platform' => "mobile",
                'image' => "",
            ],
            [
                'title' => "Android",
                'description' => "An Android/Tablet app (excluding backend)",
                'value' => "android",
                'platform' => "mobile",
                'image' => "",
            ],
        ];
        $data = [

            [
                'question' => [
                    'title' => "How big is your app?",
                    'title_fr' => "Quelle est la taille de votre application?",
                    'name' => "app_size",
                    'type' => "radio",
                    // 'order' => 1,
                    'image' => "",
                ],
                'answers' => [
                    [
                        'title' => "Small",
                        'title_fr' => "Petite",
                        'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/small@2x-d58c5d533621f5fe7ffd8f4cbdd556ebdb723639c371de1570405064fd0ade61.png",
                        'value' => "small",
                        'content' => "5",
                        'content_type' => "base_days",
                    ],
                    [
                        'title' => "Medium",
                        'title_fr' => "Moyenne",
                        'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/medium@2x-3f73284910e08d5750e163b0a57ba1e2950428883a8b4e7e9b0a84222769046e.png",
                        'value' => "medium",
                        'content' => "10",
                        'content_type' => "base_days",
                    ],
                    [
                        'title' => "Large",
                        'title_fr' => "Grande",
                        'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/large@2x-c7fc2c376674be4b7afabc7292144218c991c7c2e1b7a126d0040e607db43da5.png",
                        'value' => "large",
                        'content' => "15",
                        'content_type' => "base_days",
                    ],
                ],
            ],
                [
                    'question' => [
                        'title' => "What level of UI would you like?",
                        'title_fr' => "Quel niveau de design souhaitez-vous ?",
                        'name' => "app_ui",
                        'type' => "radio",
                        'image' => "",
                    ],
                    'answers' => [
                        [
                            'title' => "MVP",
                            'title_fr' => "MVP",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/mvp@2x-9434764c1bc0fbfb2a3eff18f45ceb107951a46993b4cd446d6702078a1bcb89.png",
                            'value' => "mvp",
                            'content' => 5,
                            'content_type' => "percentage",
                        ],
                        [
                            'title' => "Basic",
                            'title_fr' => "Basique",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/basic@2x-1b2b2488069b31b0f0dbc2a74f2e9db36e60f47009473bdcb42001c369e4549c.png",
                            'value' => "basic",
                            'content' => 10,
                            'content_type' => "percentage",
                        ],
                        [
                            'title' => "Polished",
                            'title_fr' => "Poli",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/polished@2x-4f3e2b9c22e6351d650d650bd5e8c75b7db7c286f5195cd2fa75a76fe569aa7e.png",
                            'value' => "polished",
                            'content' => 15,
                            'content_type' => "percentage",
                        ],
                    ],
                ],
                [
                    'question' => [
                        'title' => "Users & Accounts",
                        'title_fr' => "Utilisateurs & Comptes",
                        'name' => "app_user_accounts",
                        'image' => "",
                    ],
                    'answers' => [
                        [
                            'title' => "Email / Password Sign Up",
                            'title_fr' => "Inscription Email/Mot de passe",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/email_password_sign_up@2x-a5cf07d56027a867ce801374a02948cc4ea3067ca6d857c7a4a6ffe1682c90ca.png",
                            'value' => "email_password",
                            'content' => 1,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Facebook Sign Up",
                            'title_fr' => "Inscription Facebook",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/facebook_sign_up@2x-46a0d49da8179794cc9297cd0a4fb6290578a27b4109aa99718508c38736bdda.png",
                            'value' => "facebook",
                            'content' => 2,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Twitter Sign Up",
                            'title_fr' => "Inscription Twitter",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/twitter_sign_up@2x-b4c574ccb07b8044b63042c1733df3948b4394d2cb477cda54e6b3702ca0de06.png",
                            'value' => "twitter",
                            'content' => 2,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Google Sign Up",
                            'title_fr' => "Inscription Google",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/google_sign_up@2x-c773648d1999c26fcd27151d61aeb24712438c21ad95e231dd21d70a91742ac9.png",
                            'value' => "google",
                            'content' => 2,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Github Sign Up",
                            'title_fr' => "Inscription Github",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/github_sign_up@2x-7b55964a246f6452cf214756d22f9068339d9e032b286e74b70de2ebbe72842e.png",
                            'value' => "github",
                            'content' => 2,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "LinkedIn Sign Up",
                            'title_fr' => "Inscription LinkedIn",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/linkedin_sign_up@2x-1bfd2074927c7eba61df0066bad279b88bfd6420bb42f5fc7c2dd5c743b41466.png",
                            'value' => "linkedin",
                            'content' => 2,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "User invitation emails",
                            'title_fr' => "Emails d'invitation utilisateurs",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/user_invitation_email@2x-84e90c98a22d5b9b07f13fe4a485533e0911aecf628e266bf36a107d9091e476.png",
                            'value' => "user_invitation_emails",
                            'content' => 2,
                            'content_type' => "days",
                        ],
                        // [
                        //     'title' => "Multi-tenant Accounts",
                        //     'title_fr' => "C"
                        //     'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/multi_tenant_account@2x-286004fadb58cc30be65bf160fc9789e211c6a45abcac0f19303449f151d67cd.png",
                        //     'value' => "mutitenant",
                        //     'content' => 3,
                        //     'content_type' => "days",
                        // ],
                        // [
                        //     'title' => "Subdomains",
                        //     'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/subdomains@2x-8eb8f8e144d940b06a2d96abe6fa4de6d5bc5ff7a1ca74897dd04178797505b6.png",
                        //     'value' => "subdomains",
                        //     'content' => 4,
                        //     'content_type' => "days",
                        // ],
                        // [
                        //     'title' => "Custom domains",
                        //     'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/custom_domains@2x-988309aebe6e4091c5a7ca5b1dff052fe027ea7764ddde8448082123c140e3e7.png",
                        //     'value' => "custom_domains",
                        //     'content' => 4,
                        //     'content_type' => "days",
                        // ],
                    ],
                ],

                [
                    'question' => [
                        'title' => "User Generated Content",
                        'title_fr' => "Contenu généré par les utilisateurs",
                        'name' => "user_generated_content",
                        'image' => "",
                    ],
                    'answers' => [
                        [
                            'title' => "Dashboard",
                            'title_fr' => "Tableau de bord",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/dashboard@2x-0796792d9292f29eccff5bb7225ef9a41aa3b575d66474675e31db44cd95d8c0.png",
                            'value' => "dashboard",
                            'content' => 5,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Activity Feed",
                            'title_fr' => "Fil d'activité",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/activity_feed@2x-b994138610c0e95b05ff52eecb34cd59659256268b2f72c9361bfa47ecb19544.png",
                            'value' => "activity_feed",
                            'content' => 3,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "File Uploading",
                            'title_fr' => "Upload de fichiers",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/file_uploading@2x-917a6a59d419d662266d76c74826e484cc1e9efddd555f8254ea965c47c6b405.png",
                            'value' => "file_uploading",
                            'content' => 1,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "User Profiles",
                            'title_fr' => "Profils utilisateurs",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/user_profiles@2x-0226ea4d7cd7d13349ab4bf493bca8940dafa942597056a536275cfba2b83ee8.png",
                            'value' => "user_profiles",
                            'content' => 2,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Transactional Emails",
                            'title_fr' => "Emails transactionnels",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/transactional_emails@2x-486eeb3544c154bb40a405c3f39f3d436ca700df39f5e8606b82b1d6085d8e67.png",
                            'value' => "transactional_emails",
                            'content' => 2,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Tags",
                            'title_fr' => "Tags",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/tags@2x-b8f1b03849bce48c18740494e6e45913f86ec40d9c1378cf817a4a7243bebbf7.png",
                            'value' => "tags",
                            'content' => 2,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Ratings or reviews",
                            'title_fr' => "Avis ou revues",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/ratings_review@2x-ddfcaf9789bf046b9923d7457f9246969fb319351b7088af9078dc41b267a01e.png",
                            'value' => "ratings_or_reviews",
                            'content' => 4,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Audio/Video processing",
                            'title_fr' => "Traitement audio/video",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/audio_video_processing@2x-6f14ebb4c1cade64289205d316a94b09c8ff50348e0ba5aa0f3616db956564c0.png",
                            'value' => "audio_video_processing",
                            'content' => 3,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Free text searching",
                            'title_fr' => "Recherche de texte",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/free_text_searching@2x-1521bc5f4e34274621908dc5cf25b850ae0bfc0e43bfc4ec7ca37e50c6fb3f4d.png",
                            'value' => "free_text_searching",
                            'content' => 2,
                            'content_type' => "days",
                        ],
                    ],
                ],
                [
                    'question' => [
                        'title' => "Dates & Locations",
                        'title_fr' => "Dates & Positions",
                        'name' => "dates_and_locations",
                        'image' => "",
                    ],
                    'answers' => [
                        [
                            'title' => "Calendaring",
                            'title_fr' => "Calendrier",
                            'value' => "calendaring",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/calendaring@2x-8e69b667148b2837524a59b4f970328fc005c7f9bb074db13fc736c472598ca4.png",
                            'content' => 5,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Display of Map data / Geolocation",
                            'title_fr' => "Affichage de données de carte / Géolocation",
                            'value' => "map_data_or_geolocation",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/map_data_geolocation@2x-0a2a0ea1d1326e9d47a7292dcd7ca25f886a42cbb372aed1664f8752d66ebed8.png",
                            'content' => 2,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Display of custom map markers/regions",
                            'title_fr' => "Affichage personnalisé de marqueurs ou régions",
                            'value' => "custom_markers_or_region",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/map_markers_regions@2x-1ce1727262f96ab9f48fe53293af37897bd8618d69604bb7a79aaea2f88c461e.png",
                            'content' => 2,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Bookings",
                            'title_fr' => "Réservations",
                            'value' => "bookings",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/bookings@2x-d1441717a32c0c988b634fb738a250dbf18037531d8543b4a5be18cc7163d2f2.png",
                            'content' => 5,
                            'content_type' => "days",
                        ],
                    ],
                ],
                [
                    'question' => [
                        'title' => "Social & Engagement",
                        'title_fr' => "Engagement social",
                        'name' => "social_and_engagement",
                        'image' => "",
                    ],
                    'answers' => [
                        [
                            'title' => "Messaging",
                            'title_fr' => "Messagerie",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/messaging@2x-2f2fad9e71b026c18bc409500e8aadbd1f19e6e65380ad957f08597c197b00d2.png",
                            'value' => "messaging",
                            'content' => 7,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Forums or commenting",
                            'title_fr' => "Forums or commentaires",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/forums_commenting@2x-cfc8f8db3cb97faf58906b2e9c75d8639f54e82788a775a1dd9cfb974f2ce01a.png",
                            'value' => "forums_or_commenting",
                            'content' => 4,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Social Sharing",
                            'title_fr' => "Partage sur les réseaux sociaux",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/social_sharing@2x-da6ca47d4261f0bb59ec0c3dad050ce9af0ce8d949d16c9876c9bc00d4adee7a.png",
                            'value' => "social_sharing",
                            'content' => 1,
                            'content_type' => "days",
                        ],
                        // [
                        //     'title' => "Push to Facebook Open Graph",
                        //     'title_fr' => "Push to Facebook Open Graph",
                        //     'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/facebook_open_graph@2x-f7cb23d0bb2929d5af39e9630e04998e50004dedb9a0c0191bc7f7af7710e774.png",
                        //     'value' => "push_to_facebook_opengraph",
                        //     'content' => 5,
                        //     'content_type' => "days",
                        // ],
                    ],
                ],
                [
                    'question' => [
                        'title' => "Billing & eCommerce",
                        'title_fr' => "Paiements et e-commerce",
                        'name' => "billing_and_ecommerce",
                        // 'type' => "",
                        'image' => "",
                    ],
                    'answers' => [
                        [
                            'title' => "Subscription plans",
                            'title_fr' => "Modèles de souscriptions",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/subscription_plans@2x-68b34daa7eb97d48e144e397c08705ec4857c8923e4821a2215eacedad62c8d6.png",
                            'value' => "subscription_plans",
                            'content' => 5,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Payment processing",
                            'title_fr' => "Traitement de paiements",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/payment_processing@2x-fc0b2e76b0bafb102a6f13efa0069618876f9616b45e6a8fe7b6688a35f75a8d.png",
                            'value' => "payment_processing",
                            'content' => 5,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Shopping Cart",
                            'title_fr' => "Panier d'achat",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/shopping_cart@2x-4b88c69909121d085b92ab460aa27280c152f9dd8db6e8f093891f92fc31d5e4.png",
                            'value' => "shopping_cart",
                            'content' => 4,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "User Marketplace",
                            'title_fr' => "Marché utilisateur",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/user_marketplace@2x-b445490db17185dec82e9c69f8c5800582cb69d1efe0976001199529232d6818.png",
                            'value' => "user_marketplace",
                            'content' => 10,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Product Management",
                            'title_fr' => "Gestion de produit",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/data_admin_pages@2x-66ecc24c142af13353d933f4d16c5b4c47f3899da2454b1b5fe02dc69c21d15c.png",
                            'value' => "product_management",
                            'content' => 3,
                            'content_type' => "days",
                        ],
                    ],
                ],
                [
                    'question' => [
                        'title' => "Admin, Feedback & Analytics",
                        'title_fr' => "Administration, Feedback & Analytique",
                        'name' => "admin_feedback_and_analytics",
                        // 'type' => "",
                        'image' => "",
                    ],
                    'answers' => [
                        [
                            'title' => "CMS Integration",
                            'title_fr' => "Intégration de CMS",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/cms_integration@2x-eee84be4ad499fc926fc1018b2204f3358f3e9ab6db6b4a8135bce8f112a7399.png",
                            'value' => "cms_integration",
                            'content' => 5,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "User Admin pages",
                            'title_fr' => "Interface d'administration",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/user_admin_pages@2x-f0f9def4d4b1156f62053d42699e574bc1bbc12a0b236938a6c573f2df2f2eda.png",
                            'value' => "user_admin_pages",
                            'content' => 4,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Moderation / Content Approval",
                            'title_fr' => "Modération/Vérification de contenu",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/moderation_content_approval@2x-0dc4a22eb32a6aa23e56b40e6ec91b669bf75ffa41cb31bb0374c2481c1307de.png",
                            'value' => "moderation_content_approval",
                            'content' => 3,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Intercom",
                            'title_fr' => "Intercom",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/intercom@2x-14d426309b15542f20d8feb59fb2128b22065699563efec48f21bd88b298f52d.png",
                            'value' => "intercom",
                            'content' => 3,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Usage Analytics",
                            'title_fr' => "Statistiques d'utilisation",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/user_analytics@2x-57d30d34ddfb1693e990b035837579174fd5075a87e2a2e78bfebdaa385993c7.png",
                            'value' => "usage_analytics",
                            'content' => 4,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Crash Reporting",
                            'title_fr' => "Rapport d'erreur",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/crash_reporting@2x-ffdfa0f67fb7b63995e35129d328fbb29dc9e649ddde2e9a2f7f5f56fe104699.png",
                            'value' => "crash_reporting",
                            'content' => 2,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Performance Monitoring",
                            'title_fr' => "Suivi de performance",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/performance_management@2x-825ad932cc52fbe23c423f1a8c9dace1a2a73394dfa8ca313cf256e06de28d8a.png",
                            'value' => "performance_monitoring",
                            'content' => 4,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "Multilingual Support",
                            'title_fr' => "Support langues multiples",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/multilingual_support@2x-23a8d97e31bb2056b1a105301b5a19b8fc1e90bef2d68f037c8945d76bacc362.png",
                            'value' => "multilingual_support",
                            'content' => 3,
                            'content_type' => "days",
                        ],
                    ],
                ],
                [
                    'question' => [
                        'title' => "External APIs and Integrations",
                        'title_fr' => "API externes et intégrations",
                        'name' => "external_apis_and_integrations",
                        // 'type' => "",
                        'image' => "",
                    ],
                    'answers' => [
                        [
                            'title' => "Connect to one or more third party services",
                            'title_fr' => "Connexion à un ou plusieurs services tiers",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/third_party_services@2x-0e6189f4ae932f4f5189e93f659653eea3f272a0fc72e4c98537fab3dd3b5285.png",
                            'value' => "connect_to_one_or_more_third_party_services",
                            'content' => 4,
                            'content_type' => "days",
                        ],
                        [
                            'title' => "An API for others to integrate with your app",
                            'title_fr' => "Une API pour que d'autres services intègre votre application",
                            'image' => "https://d3h99m5mv5zvgz.cloudfront.net/assets/build_api@2x-104643c5918142ef46896c641a4b0166426b674b5af79de2227b078b0fd08d9d.png",
                            'value' => "an_api_for_others_to_integrate_with_your_app",
                            'content' => 5,
                            'content_type' => "days",
                        ],

                    ],
                ],
                // [
                //     'question' => [
                //         'title' => "",
                //         'name' => "",
                //         'type' => "",
                //         'image' => "",
                //     ],
                //     'answers' => [
                //         [
                //             'title' => "",
                //             'image' => "",
                //             'value' => "",
                //             'content' => 10,
                //             'content_type' => "days",
                //         ],
                //     ],
                // ],

            // mobile questions
        ];

        // ui_field_name == "app_ui"
        Settings::add("ui_field_name", "app_ui");

        //
        // create types
        AppEstimationType::insert($app_types);

        $app_type = AppEstimationType::where('platform', "web")->first();
        // for web
        $order = 0;
        /** Insert questions */
        // add questions and answears in each questionaire
        foreach($data as $questionaire){

            $question = $questionaire['question'];
            $question['app_estimation_type_id'] = $app_type->id;
            $question['order'] = $order;

            // insert the question
            $q = AppEstimationQuestion::create($question);

            // insert the answers
            $answers = $questionaire['answers'];

            foreach ($answers as $answer) {
                $answer['app_estimation_question_id'] = $q->id;
                AppEstimationAnswer::create($answer);
            }
            $order++;
        }
    }
}

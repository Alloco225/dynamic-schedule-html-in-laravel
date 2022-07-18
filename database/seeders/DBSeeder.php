<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Profile;
use App\Models\ProfileItem;
use App\Models\ProfileHobby;
use App\Models\ProfileLanguage;
use App\Models\ProfileSkill;
use Illuminate\Database\Seeder;
use App\Models\ProfileTechnology;
use App\Models\ProfileTechnologyGroup;
use App\Models\ProfileWork;
use Illuminate\Support\Facades\Hash;

class DBSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {

        $user = [
            'name' => "Amane Hosanna",
            'email' => "amane.dev@gmail.com",
            'password' => Hash::make("h3llo_w0rld"),
        ];

        $h_ = '<i class="material-icons mr-5 md:mr-2">';
        $_h = '</i>';

        //
        $profile =
            [
                'name' => "Hosanna AMANE",
                'first_name' => "Amané",
                'last_name' => "Hosanna",
                'picture' => "/images/me_bw.jpg",
                'about' => "Hi there, hello. It's me I'm a fullstack dev"
            ];
        $profileItems = [
            [
                'html_icon' => $h_."assignment_ind".$_h,
                'html_image' => "",
                'label' => "",
                'value' => "Fullstack Laravel & Flutter Developer",
                'link' => "#",
            ],
            [
                'html_icon' => $h_."home".$_h,
                'html_image' => "",
                'label' => "",
                'value' => "Abidjan, Côte d'Ivoire &#x1f1e8;&#x1f1ee;",
                'link' => "#",
            ],
            [
                'html_icon' => $h_."email".$_h,
                'html_image' => "",
                'label' => "",
                'value' => "hello@amane.dev",
                'link' => "mailto:hello@amane.dev",
            ],
            [
                'html_icon' => $h_."phone".$_h,
                'html_image' => "",
                'label' => "",
                'value' => "+2250574936826",
                'link' => "tel:+2250574936826",
            ],
        ];
        //
        $skills = [
            [
                'html_icon' => "",
                'image_icon' => "",
                'label' => "Team Management",
                'value' => "Can asset a teams strenf n wikness",
            ],
            [
                'html_icon' => "",
                'image_icon' => "",
                'label' => "Projekt Management",
                'value' => "Projekt goes weeee",
            ],
            [
                'html_icon' => "",
                'image_icon' => "",
                'label' => "Efficience",
                'value' => "I am speed",
            ],
        ];
        //
        $technology_groups = [
            [
                'html_icon' => "",
                'label' => "Web",
                'value' => "",
            ],
            [
                'html_icon' => "",
                'label' => "Mobile",
                'value' => "",
            ],
            [
                'html_icon' => "",
                'label' => "Design",
                'value' => "",
            ],
            [
                'html_icon' => "",
                'label' => "",
                'value' => "Extra",
            ],
        ];
        //
        $technologies = [
            [
                'profile_technology_group_id' => 1,
                'html_image' => "",
                'image_url' => "",
                'label' => "Tailwind css",
                'progress' => 90,
            ],
            [
                'profile_technology_group_id' => 1,
                'html_image' => "",
                'image_url' => "",
                'label' => "Alpine js",
                'progress' => 85,
            ],
            [
                'profile_technology_group_id' => 1,
                'html_image' => "",
                'image_url' => "",
                'label' => "Laravel",
                'progress' => 80,
            ],
            [
                'profile_technology_group_id' => 2,
                'html_image' => "",
                'image_url' => "",
                'label' => "Flutter",
                'progress' => 80,
            ],
            [
                'profile_technology_group_id' => 3,
                'html_image' => "",
                'image_url' => "",
                'label' => "Figma",
                'progress' => 70,
            ],
        ];
        //
        $languages = [
            [
                'html_icon' => "<span>&#x1f1ec;&#x1f1e7;</span>",
                'label' => "English",
                'progress' => 80,
                'value' => "Intermediate",
            ],
            [
                'html_icon' => "<span>&#x1f1eb;&#x1f1f7;</span>",
                'label' => "French",
                'progress' => 99,
                'value' => "Native",
            ],
            [
                'html_icon' => "<span>&#x1f1ef;&#x1f1f5;</span>"
                ,
                'label' => "Japanese",
                'progress' => 65,
                'value' => "Fluent",
            ],
            [
                'html_icon' => "<span>&#x1f1ea;&#x1f1f8;</span>"
                ,
                'label' => "Spanish",
                'progress' => 10,
                'value' => "Meh",
            ],
            [
                'html_icon' => "<span>&#x1f1ef;&#x1f1f5;</span>"
                ,
                'label' => "Russian",
                'progress' => 5,
                'value' => "Oh, I just like the accent",
            ],
        ];
        //

        $hobbies = [
            [
                'html_icon' => $h_."palette".$_h,
                'html_image' => "",
                'label' => "Art",
            ],
            [
                'html_icon' => $h_."videogame_asset".$_h,
                'html_image' => "",
                'label' => "Gaming",
            ],
            [
                'html_icon' => $h_."pool".$_h,
                'html_image' => "",
                'label' => "Sport",
            ],
        ];

        //
        $works = [
            [
                'label' => "Shigoto",
                'thumbnail' => "/images/thumbs/shigoto.jpg",
                'logo' => "/images/works/logos/shigoto.png",
                'image' => "/images/works/images/shigoto.jpg",
                'cover' => "/images/works/covers/shigoto.jpg",
                'description' => "
                    Shigoto goes weeeee
                ",
                'url' => "https://shigoto.amane.dev/",
            ],
            [
                'label' => "FoodLabs",
                'thumbnail' => "/images/thumbs/foodlabs.jpg",
                'logo' => "/images/works/logos/foodlabs.png",
                'image' => "/images/works/images/foodlabs.jpg",
                'cover' => "/images/works/covers/foodlabs.jpg",
                'description' => "
                    Food Is delicious
                ",
                'url' => "https://foodlabs.amane.dev/",
            ],
            [
                'label' => "Chic Dame Make Up",
                'thumbnail' => "/images/thumbs/chic_dame.jpg",
                'logo' => "/images/works/logos/chic_dame.png",
                'image' => "/images/works/images/chic_dame.jpg",
                'cover' => "/images/works/covers/chic_dame.jpg",
                'description' => "
                    Confiez-vous aux mains qui sauront apporter un plus à votre beauté en vous donnant l’élégance
                    qui vous démarquera parmi tant d’autre.
                ",
                'url' => "https://chic-dame-makeup.amane.dev/",
            ],
            [
                'label' => "VisVas",
                'thumbnail' => "/images/thumbs/visvas.jpg",
                'logo' => "/images/works/logos/visvas.png",
                'image' => "/images/works/images/visvas.jpg",
                'cover' => "/images/works/covers/visvas.jpg",
                'description' => "
                    Confiez-vous aux mains qui sauront apporter un plus à votre beauté en vous donnant l’élégance
                    qui vous démarquera parmi tant d’autre.
                ",
                'url' => "https://visvas.amane.dev/",
            ],

        ];

        User::create($user);
        Profile::create($profile);
        //
        ProfileItem::insert($profileItems);
        ProfileSkill::insert($skills);
        ProfileTechnologyGroup::insert($technology_groups);
        ProfileTechnology::insert($technologies);
        ProfileLanguage::insert($languages);
        ProfileHobby::insert($hobbies);
        ProfileWork::insert($works);

    }
}

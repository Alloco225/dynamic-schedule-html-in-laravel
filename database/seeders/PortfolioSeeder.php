<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PortfolioSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //

        $projects = [
            [
                'project_name' => "Zero Malaria",
                'logo_url' => "",
                'url' => "",
                'description' => "",
                'cover_url' => "",
                'images' => "",
                'features' => "",
                'technologies' => "",
                'data' => "",
                'client' => "Because Why Not",
            ]
        ];


        DB::connection('portfolio')->insert($projects);
    }
}

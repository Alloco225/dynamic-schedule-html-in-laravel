<?php

namespace Database\Seeders;

use App\Models\Settings;
use Illuminate\Database\Seeder;

class SettingsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //

        $settings = [
            // 'developer_day_ci' => 20000,
            // 'designer_day_ci' => 15000,
            // 'currency' => "F cfa",
            // 'currency_ci' => "F cfa",
            'developer_day' => 200,
            'developer_day_fr' => 20000,
            'designer_day' => 100,
            'designer_day_fr' => 10000,
            'currency' => "USD",
            'currency_fr' => "XOF",
        ];

        foreach ($settings as $key => $value) {
            Settings::add($key, $value);
        }
    }
}

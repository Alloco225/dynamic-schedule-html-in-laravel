@section('styles')
    <style>
        html,
        body {
            height: 100vh !important;
        }

    </style>

    <style>
        /* ---- reset ---- */
        body {
            margin: 0;
            font: normal 75% Arial, Helvetica, sans-serif;
        }

        canvas {
            display: block;
            vertical-align: bottom;
        }

        /* ---- particles.js container ---- */
        #particles-js {
            position: absolute;
            width: 100%;
            height: 100%;
            background-color: #1f1c37;
            background-image: url("");
            background-repeat: no-repeat;
            background-size: cover;
            background-position: 50% 50%;
        }

        /* ---- stats.js ---- */
        .count-particles {
            background: #000022;
            position: absolute;
            top: 48px;
            left: 0;
            width: 80px;
            color: #13E8E9;
            font-size: .8em;
            text-align: left;
            text-indent: 4px;
            line-height: 14px;
            padding-bottom: 2px;
            font-family: Helvetica, Arial, sans-serif;
            font-weight: bold;
        }

        .js-count-particles {
            font-size: 1.1em;
        }

        #stats,
        .count-particles {
            -webkit-user-select: none;
            margin-top: 5px;
            margin-left: 5px;
        }

        #stats {
            border-radius: 3px 3px 0 0;
            overflow: hidden;
        }

        .count-particles {
            border-radius: 0 0 3px 3px;
        }

    </style>

@endsection


<main class="h-full font-medium text-sm bg-gray-100">
    {{-- <div id="hero" class="h-full">
        <div id="particles-js">
            <div class="wrapper mx-auto md:w-11/12 lg:w-10/12 xl:w-9/12">

                <div class="text-3xl text-white text-center">
                    Amane Hosanna
                </div>
            </div>
        </div>
    </div> --}}
    <div class="wrapper h-full  mx-auto md:w-11/12 lg:w-10/12 xl:w-9/12">
        <div class="h-56"></div>

        <div x-data="{currentTab : 'price'}" x-init="currentTab = 'price'" class="grid grid-cols-10 rounded-md">
            <div class="col-span-2">
                <div id="tab-1" x-on:click="currentTab = 'price'"
                    class="tab p-5 flex-col justify-center items-start border rounded-l-md cursor-pointer hover:bg-red-100"
                    {{-- :class="{'bg-blue-50': currentTab != 'price'}" --}} :class="{ 'bg-red-500 text-white': currentTab === 'price' }">
                    <svg class="w-7 h-7" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                        <path
                            d="M10.394 2.08a1 1 0 00-.788 0l-7 3a1 1 0 000 1.84L5.25 8.051a.999.999 0 01.356-.257l4-1.714a1 1 0 11.788 1.838L7.667 9.088l1.94.831a1 1 0 00.787 0l7-3a1 1 0 000-1.838l-7-3zM3.31 9.397L5 10.12v4.102a8.969 8.969 0 00-1.05-.174 1 1 0 01-.89-.89 11.115 11.115 0 01.25-3.762zM9.3 16.573A9.026 9.026 0 007 14.935v-3.957l1.818.78a3 3 0 002.364 0l5.508-2.361a11.026 11.026 0 01.25 3.762 1 1 0 01-.89.89 8.968 8.968 0 00-5.35 2.524 1 1 0 01-1.4 0zM6 18a1 1 0 001-1v-2.065a8.935 8.935 0 00-2-.712V17a1 1 0 001 1z">
                        </path>
                    </svg>
                    <h3 class="text-lg font-semibold">Fixed Price</h3>
                </div>
                <div id="tab-2" x-on:click="currentTab = 'speed'"
                    class="tab p-5 flex-col justify-center items-start border rounded-l-md cursor-pointer hover:bg-red-100"
                    {{-- :class="{'bg-blue-50': currentTab != 'price'}" --}} :class="{ 'bg-red-500 text-white': currentTab === 'speed' }">
                    <svg class="w-7 h-7" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                        <path
                            d="M10.394 2.08a1 1 0 00-.788 0l-7 3a1 1 0 000 1.84L5.25 8.051a.999.999 0 01.356-.257l4-1.714a1 1 0 11.788 1.838L7.667 9.088l1.94.831a1 1 0 00.787 0l7-3a1 1 0 000-1.838l-7-3zM3.31 9.397L5 10.12v4.102a8.969 8.969 0 00-1.05-.174 1 1 0 01-.89-.89 11.115 11.115 0 01.25-3.762zM9.3 16.573A9.026 9.026 0 007 14.935v-3.957l1.818.78a3 3 0 002.364 0l5.508-2.361a11.026 11.026 0 01.25 3.762 1 1 0 01-.89.89 8.968 8.968 0 00-5.35 2.524 1 1 0 01-1.4 0zM6 18a1 1 0 001-1v-2.065a8.935 8.935 0 00-2-.712V17a1 1 0 001 1z">
                        </path>
                    </svg>
                    <h3 class="text-lg font-semibold">Speed</h3>
                </div>
            </div>
            <div
                class="col-span-8 relative h-60 overflow-visible border border-l-0 rounded-md rounded-l-none text-md bg-white">
                <div :class="{'absolute top-80': currentTab != 'price'}" id="tab-content-1" class="p-5 transition-all duration-300 ease-out bg-white">
                    <h2 class="text-xl font-semibold mb-2">Fixed Price</h2>
                    <div class="md:grid gap-2 grid-cols-5">
                        <div class="col-span-4">
                            <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Consequuntur, earum?</p>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Alias aperiam praesentium fuga
                                modi id
                                beatae, sint provident rem quas! Eligendi culpa minus corporis odio nulla.</p>
                        </div>
                        <div class="col-span-1">
                            <img src="/images/me_ai.png" alt="">
                        </div>
                    </div>
                    <div class="mt-1 mb-3">
                        <div class="flex items-center mt-1 font-semibold">
                            <div class="inline-flex justify-center items-center bg-blue-50 rounded-full w-8 h-8 mr-2">
                                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
                                        d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z"
                                        clip-rule="evenodd"></path>
                                </svg>
                            </div>
                            Defined time frames
                        </div>
                        <div class="flex items-center mt-1 font-semibold">
                            <div class="inline-flex justify-center items-center bg-blue-50 rounded-full w-8 h-8 mr-2">
                                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
                                        d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z"
                                        clip-rule="evenodd"></path>
                                </svg>
                            </div>
                            Defined time frames
                        </div>
                    </div>
                </div>
                <div id="tab-content-speed" :class="{'absolute top-80': currentTab != 'speed'}"
                    class="p-5  border border-l-0 rounded-md rounded-l-none bg-white transition-all duration-300 ease-out">
                    <h2 class="text-xl font-semibold">Speed</h2>
                    <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Consequuntur, earum?</p>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Alias aperiam praesentium fuga modi id
                        beatae, sint provident rem quas! Eligendi culpa minus corporis odio nulla.</p>
                    <div class="">
                        <div class="flex items-center mt-3 font-semibold">
                            <div class="inline-flex justify-center items-center bg-blue-50 rounded-full w-8 h-8 mr-2">
                                <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
                                        d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z"
                                        clip-rule="evenodd"></path>
                                </svg>
                            </div>
                            Defined time frames
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

@section('scripts')

@endsection

<div class="md:p-5 bg-purple-500 font-medium transition-all duration-300">
    <div class="md:grid md:grid-cols-5 gap-5 md:w-11/12 lg:w-10/12 xl:w-9/12 2xl:w-8/12 mx-auto ">
        <aside class="md:col-span-2 shadow-md md:rounded-md bg-white  transition-all duration-300">

            @livewire('profile-section', ['profile' => $profile])
            @livewire('skills-section', ['skills' => $profile->skills])
            @livewire('technologies-section', ['techs' => $profile->techs])
            @livewire('languages-section', ['languages' => $profile->languages])
            @livewire('hobbies-section', ['hobbies' => $profile->hobbies])

        </aside>
        <main class="md:col-span-3 shadow-md md:rounded-md bg-white pt-20 md:pt-0 relative transition-all duration-300">
            <div id="progress-indicator" class="progress-indicator absolute top-0 right-0 h-full ">
                <div class="progress-container w-0.5 h-full bg-gray-50">
                    <div id="scroll_progressbar" class="progress-bar w-0.5 h-0 bg-purple-500">
                    </div>
                </div>
            </div>
            <section id="portfolio">
                <div class="p-5 bg-purple-100 text-2xl">
                    What I'm proud of
                </div>
                <hr/>
                <div class="" x-data="{selectedId: 0}">
                    <div class="p-5">
                        <ul class="grid gap-3 lg:gap-5 grid-cols-2 sm:grid-cols-3 xl:grid-cols-5 ">
                            @for ($i = 1; $i <= 5; $i++)
                                @php
                                    $r = "/images/";
                                    $images = [
                                        "me_ai.png",
                                        "me_bw.jpg",
                                        "me_chopsticks.jpg",
                                        "me_group.jpg",
                                        "me.jpg",
                                    ];
                                    $image = $r.$images[rand(0, sizeof($images)-1)];
                                @endphp
                                <li class="p-1 rounded-md bg-purple-200 cursor-pointer hover:shadow-md transform"
                                :class="{ 'bg-purple-500 scale-110': selectedId == {{$i}}}"
                                @click="selectedId = {{$i}}">
                                    <img src="{{$image}}" alt="" class="object-cover w-full h-full">
                                </li>
                            @endfor
                        </ul>
                        <div class="flex justify-center my-5">
                            <a class="px-3 py-2 mx-auto rounded bg-purple-100 hover:bg-purple-300 cursor-pointer">See more</a>
                        </div>
                    </div>
                    <div id="work-content" class="" x-show="selectedId != 0"
                        x-transition:enter="transition ease-out duration-200"
                        x-transition:enter-start="opacity-0 transform -translate-y-10"
                        x-transition:enter-end="opacity-100 transform translate-y-0"
                        x-transition:leave="transition ease-in duration-200"
                        x-transition:leave-start="opacity-100 transform translate-y-0"
                        x-transition:leave-end="opacity-0 transform -translate-y-10"
                        class=""
                    >
                        <div class=" bg-purple-100 text-2xl">
                            <div class="p-5 flex justify-between items-center">
                                <span class="">
                                    Details
                                </span>
                                <span @click="selectedId = 0" class="hover:bg-purple-200 cursor-pointer rounded-full flex items-center p-2">
                                    <i class="material-icons">close</i>
                                </span>
                            </div>
                        </div>
                        <div class="p-5 grid gap-2 md:gap-5 md:grid-cols-3 relative">
                            <div class="absolute top-0 left-0 h-full w-16 cursor-pointer transition duration-200 ease-out bg-gradient-to-l hover:from-transparent hover:to-purple-300">
                                <span @click="selectedId -= 1;" class="w-full h-full transition duration-200 ease-out transform hover:-translate-x-4 flex justify-center items-center">
                                    <i class="material-icons text-5xl ">keyboard_arrow_left</i>
                                </span>
                            </div>
                            <div class="col-span-3 md:col-span-1 overflow-hidden rounded-full">
                                <img src="/images/me.jpg" alt="">
                            </div>
                            <div class="md:col-span-2  flex flex-col justify-between">
                                <p class="text-3xl">Lorem, ipsum dolor. <span x-text="selectedId"></span> </p>
                                <p class="">
                                    Lorem ipsum dolor sit, amet consectetur adipisicing elit. Cum, minima!
                                </p>
                                <p class="flex justify-between">
                                    <a href="">
                                        lorem.com
                                    </a>
                                    <span>
                                        <a href="">
                                            <i class="fab fa-twitter"></i>
                                            <i class="material-icons">home</i>
                                        </a>
                                        <a href="">
                                            <i class="fab fa-twitter"></i>
                                            <i class="material-icons">home</i>
                                        </a>
                                        <a href="">
                                            <i class="fab fa-twitter"></i>
                                            <i class="material-icons">home</i>
                                        </a>
                                    </span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <section id="work" x-data="{isOpen: true}">
                <hr/>
                <div class="flex justify-between mb-5 p-5 bg-purple-100">
                    <div>
                        {{-- <i class="material-icons mr-5">public</i> --}}
                        <span class="title text-2xl">Professional Experience</span>
                    </div>
                    <span @click="isOpen = !isOpen" class="cursor-pointer">
                        <i class="material-icons" x-show="isOpen == false">keyboard_arrow_down</i>
                        <i class="material-icons" x-show="isOpen == true">keyboard_arrow_up</i>
                    </span>
                </div>
                <article
                    x-show="isOpen == true"
                    x-transition:enter="transition ease-out duration-200"
                    x-transition:enter-start="opacity-0 transform -translate-y-10"
                    x-transition:enter-end="opacity-100 transform translate-y-0"
                    x-transition:leave="transition ease-in duration-200"
                    x-transition:leave-start="opacity-100 transform translate-y-0"
                    x-transition:leave-end="opacity-0 transform -translate-y-10"

                >
                    <div class="p-5">
                        <ul class="md:pl-5">
                            <li class="grid md:grid-cols-5">
                                <div class="col-span-5 md:col-span-1 flex flex-row md:flex-col ">
                                    <span>
                                        2020-04
                                    </span>
                                    <span class="ml-3 md:ml-0">
                                        Present
                                    </span>
                                </div>
                                <div class="pl-3 mb-2 col-span-5 md:col-span-4">
                                    <div class="text-xl font-semibold">
                                        <div>
                                            Lead Developer FullStack
                                        </div>
                                        <span class="ml-3 text-lg font-medium">
                                            {{-- <i class="material-icons mr-5">local_business</i> --}}
                                            <a href="" class="py-1 px-2 rounded-md hover:bg-purple-100 cursor-pointer">
                                                @ Adjemin
                                            </a>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-span-5 md:col-start-2 col-end-6">
                                    <p class="mb-1 pl-5">
                                        Lorem ipsum dolor sit, amet consectetur adipisicing elit. Fuga, atque.
                                    </p>
                                </div>
                                {{-- Single Item --}}
                                <div class="col-span-5 md:col-start-2 col-end-6">
                                    <div class="rounded-md ml-3 pl-2 p-1">
                                        <div class="w-full flex justify-between">
                                            <div class="w-full font-semibold">
                                                <span class="ml-auto py-1 px-2 rounded-md hover:bg-purple-100 flex items-center">
                                                    <i class="material-icons mr-1 transform rotate-45">link</i>
                                                    <a href="">
                                                        Seamless Javascript
                                                    </a>
                                                </span>
                                            </div>
                                            <span class="ml-3 py-1 px-2 rounded-md hover:bg-purple-100 hidden items-center">
                                                <i class="material-icons mr-1 transform rotate-45">link</i>
                                                <a href="">link.com</a>
                                            </span>
                                        </div>
                                        <div class="h-0.5 mt-1 mb-2 w-full bg-purple-500"></div>
                                        <p>
                                            Lorem ipsum dolor sit amet consectetur adipisicing elit. Eos eveniet ipsum rem illum optio provident.
                                        </p>
                                    </div>
                                </div>
                                {{-- / Single Item --}}
                                <div class="col-span-5 h-0.5 mt-1 mb-2 w-full bg-purple-500"></div>
                            </li>
                        </ul>
                    </div>
                </article>
            </section>
            <section id="education" class="pt-10">
                <div class="p-5 bg-purple-100 text-2xl">
                    {{-- <i class="material-icons mr-5">card_travel</i> --}}
                    Education
                </div>
                <hr/>
                <div class="p-5">
                    <ul class="md:pl-5">
                        <li class="grid md:grid-cols-5">
                            <div class="col-span-5 md:col-span-1 flex flex-row md:flex-col ">
                                <span>
                                    2020-04
                                </span>
                                <span class="ml-3 md:ml-0">
                                    2021-02
                                </span>
                            </div>
                            <div class="pl-3 mb-2 col-span-5 md:col-span-4">
                                <div class="text-xl font-semibold">
                                    <div>
                                        Bac C mention
                                    </div>
                                    <span class="ml-3 text-lg font-medium capitalize">
                                        {{-- <i class="material-icons mr-5">local_business</i> --}}
                                        <a href="" class="py-1 px-2 rounded-md hover:bg-purple-100 cursor-pointer">
                                            @ Lycée mixte 1
                                        </a>
                                    </span>
                                </div>
                            </div>
                            <div class="col-span-5 md:col-start-2 col-end-6">
                                <p class="mb-1 pl-5">
                                    Lorem ipsum dolor sit.
                                </p>
                            </div>
                            {{-- Single Item --}}
                            <div class="col-span-5 md:col-start-2 col-end-6">
                                <div class="rounded-md ml-3 pl-2 p-1">
                                    <div class="w-full flex justify-between">
                                        <div class="w-full font-semibold">
                                            <span class="ml-auto py-1 px-2 rounded-md hover:bg-purple-100 flex items-center">
                                                <i class="material-icons mr-1 transform rotate-45">link</i>
                                                <a href="">
                                                    Seamless Javascript
                                                </a>
                                            </span>
                                        </div>
                                        <span class="ml-3 py-1 px-2 rounded-md hover:bg-purple-100 hidden items-center">
                                            <i class="material-icons mr-1 transform rotate-45">link</i>
                                            <a href="">link.com</a>
                                        </span>
                                    </div>

                                </div>
                            </div>
                            {{-- / Single Item --}}
                            <div class="col-span-5 h-0.5 mt-1 mb-2 w-full bg-purple-500"></div>
                        </li>
                    </ul>
                </div>
            </section>
        </main>
    </div>
</div>


@section('scripts')
    @include('components.scripts.scroll_indicator')
    <script>
        // function portfolioDecrement(){
        // }
    </script>
@endsection

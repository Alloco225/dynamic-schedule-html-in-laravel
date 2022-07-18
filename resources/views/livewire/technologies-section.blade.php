            <section id="technologies" class="" x-data="{isOpen: true}">
                <div class="flex justify-between p-5 bg-purple-100">
                    <div>
                        <i class="material-icons mr-5">build</i>
                        <span class="title text-xl">Technologies</span>
                    </div>
                    <x-toggle_more @click="isOpen = !isOpen"/>
                </div>
                <!-- Skill List Container -->
                <div <x-slide_down/>>
                    <ul class="p-5" >
                        @forelse ($techs as $tech)
                            <li class="mb-3">
                                <div class="text-md mb-2">{{$tech->label}}</div>
                                <div class="rounded-full w-full h-4 bg-gray-100">
                                    <div class="flex justify-center items-center rounded-full h-4 bg-purple-500" style="width:{{$tech->progress}}%;">
                                        {{$tech->progress}}%
                                    </div>
                                </div>
                            </li>
                        @empty
                        {{--  --}}
                        @endforelse
                    </ul>
                </div>
            </section>
            <hr/>

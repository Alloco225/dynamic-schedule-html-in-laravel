            <section id="skills" class="">
                <div class="flex mb-5 bg-purple-100 p-5">
                    <i class="material-icons mr-5">toys</i>
                    <span class="title text-xl">Skills</span>
                </div>
                <!-- Skill List Container -->
                <ul class="p-5 pt-0" >
                    @foreach ($skills as $skill)
                        <li class="mb-3" x-data="{isOpen : false}">
                        <div class="flex justify-between items-center">
                            {{$skill->label}}
                            @if($skill->value != "")
                                <span @click="isOpen = !isOpen" class="cursor-pointer">
                                    <i class="material-icons" x-show="isOpen == false">keyboard_arrow_down</i>
                                    <i class="material-icons" x-show="isOpen == true">keyboard_arrow_up</i>
                                </span>
                            @endif
                        </div>
                        @if($skill->value != "")
                            <div x-show="isOpen == true"
                                x-transition:enter="transition ease-out duration-200"
                                x-transition:enter-start="opacity-0 transform -translate-y-10"
                                x-transition:enter-end="opacity-100 transform translate-y-0"
                                x-transition:leave="transition ease-in duration-200"
                                x-transition:leave-start="opacity-100 transform translate-y-0"
                                x-transition:leave-end="opacity-0 transform -translate-y-10"
                                class="rounded-md bg-purple-50 py-1 px-2"
                                >
                                {{$skill->value}}
                            </div>
                        @endif
                    </li>
                    @endforeach
                </ul>
            </section>
            <hr/>

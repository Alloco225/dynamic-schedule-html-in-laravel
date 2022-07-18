            <section id="languages" class=""  x-data="{isOpen : false }">
                <div class="flex justify-between p-5 bg-purple-100">
                    <div>
                        <i class="material-icons mr-5">public</i>
                        <span class="title text-xl">Languages</span>
                    </div>
                    <x-toggle_more @click="isOpen = !isOpen" />
                </div>
                <!-- Languages List -->
                <ul class="p-5 pt-5">
                    @forelse ($languages as $language)
                        <li class="w-full mb-3">
                            <div class="text-md mb-2">

                                {{$language->label}}
                                {!!$language->html_icon!!}
                            </div>
                            <div class="rounded-full w-full h-2 bg-gray-100">
                                <div class="flex justify-center items-center rounded-full h-2 bg-purple-500" style="width:{{$language->progress}}%;">
                                </div>
                            </div>
                            <div class="flex justify-end">
                                <span class=" mt-2 py-1 px-2 hover:bg-purple-100 rounded-md cursor-pointer">
                                    {{$language->value}}
                                </span>
                            </div>
                        </li>
                    @empty

                    @endforelse
                    <div x-show="isOpen == true"
                            <x-slide_down/>>
                            <ul>
                                @forelse ($secondary_languages as $language)
                                    <li class="w-full mb-3">
                                        <div class="text-md mb-2">

                                            {{$language->label}}
                                            {!!$language->html_icon!!}
                                        </div>
                                        <div class="rounded-full w-full h-2 bg-gray-100">
                                            <div class="flex justify-center items-center rounded-full h-2 bg-purple-500" style="width:{{$language->progress}}%;">
                                            </div>
                                        </div>
                                        <div class="flex justify-end">
                                            <span class=" mt-2 py-1 px-2 hover:bg-purple-100 rounded-md cursor-pointer">
                                                {{$language->value}}
                                            </span>
                                        </div>
                                    </li>
                                @empty
                                    {{--  --}}
                                @endforelse
                            </ul>
                        </div>
                    </li>
                </ul>
            </section>
            <hr/>

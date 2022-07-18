            <section id="profile">
                <div class="w-full h-96 md:h-72 lg:h-96 relative overflow-hidden sm:hidden md:block">
                    <img src="{{$profile->picture}}" alt="" class="w-full object-cover md:rounded-t-md">
                    <div class="absolute w-full bottom-0 pl-5 py-3  text-2xl font-medium  bg-purple-200 bg-opacity-90">
                        {{$profile->name}}
                    </div>
                </div>
                <div class="w-full h-56 hidden sm:flex md:hidden p-5">
                    <img src="{{$profile->picture}}" alt="" class="w-44 h-44 object-cover rounded-full">
                    <div class="ml-10 mt-5">
                        <p class=" text-4xl font-medium text-black">{{$profile->name}}</p>
                        <p class="mt-5">
                            {{
                            $profile->about ?? "Hi there, hello.
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda nisi voluptate et, dolor fuga reprehenderit culpa perferendis omnis obcaecati nobis."
                            }}
                        </p>
                    </div>
                </div>
                <div class="p-5">
                    <ul>
                        @forelse ($profile_items as $item)
                            <li class="mb-3">
                                @if($item->link != "#")
                                    <a href="{{$item->link}}" class=" flex items-center">
                                        {!!$item->html_icon!!}
                                        <span>{{$item->value}}</span>
                                    </a>
                                @else
                                    <li class="mb-3 flex items-center">
                                        {!!$item->html_icon!!}
                                        <span>{!!$item->value!!}</span>
                                    </li>
                                @endif
                            </li>
                        @empty
                            {{--  --}}
                        @endforelse
                    </ul>
                </div>
            </section>
            <hr/>

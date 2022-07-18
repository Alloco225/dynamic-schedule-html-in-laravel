
            <section id="hobbies" class="">
                <div class="flex p-5 bg-purple-100">
                    <i class="material-icons mr-5">beach_access</i>
                    <span class="title text-xl">Hobbies</span>
                </div>
                <!-- Hobbies List -->
                <ul class="p-5 flex flex-wrap justify-between">
                    @forelse ($hobbies as $hobby)
                        <li class="mb-3 flex items-center rounded-md py-2 px-3 hover:bg-purple-100 cursor-pointer">
                            {!! $hobby->html_icon !!}
                            <span class="title text-xl">{{$hobby->label}}</span>
                        </li>
                    @empty
                        {{--  --}}
                    @endforelse

                </ul>
            </section>

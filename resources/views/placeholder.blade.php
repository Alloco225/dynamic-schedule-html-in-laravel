@extends('layouts.app')
@section('content')

<div class="flex flex-col items-center justify-center h-96">
    @php
        $gifs = [
            'sign',
            'animated',
            'cartoon',
            'cat',
            'ded',
            'fancy',
            'fingers',
            'relax'
        ];

        $i = date('H');

        $i = (int)$i;

        $coding = $i >= 10 && $i < 20;
        // $coding = true;

        // $b = 24/($i+1);

        // if($b > sizeof($gifs) || $b < 0){
        //     $b = rand(0, sizeof($gifs) -1);
        // }
        $b = rand(0, sizeof($gifs) -1);
        $c = $gifs[$b];

        $img = "/img/gifs/typing_$c.gif";

        if(!$coding){
            $img = "/img/gifs/sleeping.gif";
        }
        @endphp
    <div class="w-full">
        <img src="{{$img}}" alt="" class="w-full h-auto">
    </div>
    {{-- <p class="text-red-500 absolute top-74">
        >>Vos services seront remis en ligne sous peu<<
    </p> --}}
    <div class="mt-3 text-3xl text-center font-semibold text-gray-700">
        <p class="text-center">
            @if($coding)
            >This Site Is Being reCoded<
            @else
            This Site Is >Not< Being reCoded
            @endif
            <br/>
            <div class="text-center">
                But you can
                    <a x-data="{tooltip:false}" x-on:mouseover="tooltip = true" x-on:mouseleave="tooltip = false" href="tel:+22574936826" class="cursor-pointer text-red-500 underline relative mr-2 inline-block">
                        <div class="relative" x-cloak x-show.transition.origin.top="tooltip">
                            <div style="z-index: 999" class="absolute bg-white top-0 z-50 w-32 p-2 -mt-1 text-sm leading-tight text-black transform -translate-x-1/2 -translate-y-full bg-orange-500 rounded-lg shadow-lg">
                                I'm an introvert, please please mail me instead TT
                            </div>
                        </div>
                        <del>
                            Call
                        </del>
                    </a>
                    <a x-data="{tooltip:false}" x-on:mouseover="tooltip = true" x-on:mouseleave="tooltip = false" href="mailto:hello@amane.dev" class="cursor-pointer text-blue-500 underline relative mr-2 inline-block">
                        <div class="relative" x-cloak x-show.transition.origin.top="tooltip">
                            <div style="z-index: 999" class="absolute bg-white top-0 z-50 w-32 p-2 -mt-1 text-sm leading-tight text-black transform -translate-x-1/2 -translate-y-full bg-orange-500 rounded-lg shadow-lg">
                                Yes! yes, I'll reply @if($coding) in the hour @else first thing when i wake up @endif XD
                            </div>
                        </div>
                        Mail
                    </a>
                    me if you have a web/mobile app project
            </div>

            <div class="text-center mt-5">
                Or just check
                    <a href="/estimation-de-projet/en" class="cursor-pointer text-gray-500 underline relative mr-2 inline-block">
                        how much does your web application cost
                    </a>
            </div>
        </p>
    </div>
</div>

@endsection

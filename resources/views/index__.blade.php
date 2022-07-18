@extends('layouts.app')
@section('content')
<style>
    html, body{
        height: 100vh;
    }
</style>
<main class="h-full flex flex-col justify-between">
    <section id="hero" class="h-full w-full">
        <div class=" width h-full">
            {{-- <div class="project rounded mt-5 md:mt-10 mx-auto w-40"> --}}
                {{-- @include('inc.svg.meh', ['class' => "h-full w-auto"]) --}}
                <img src="/images/meh_.png" class="h-full w-auto mx-auto" alt="">
            {{-- </div> --}}
        </div>
    </section>
    {{--  --}}
    <section id="specs">
        <div class=" grid grid-cols-3 h-64">
            <div class="bg-green-100">
                <h2>Application Sur Mesure</h2>
            </div>
            <div class="bg-blue-100">
                <h2>Interface facile à utiliser</h2>
            </div>
            <div class="bg-red-100">
                <h2>Ultra performante</h2>
            </div>
        </div>
    </section>

    {{-- CTA --}}
    <section id="cta">
        <div class="text-center">
            <h3>Let's build something great together</h3>
            <p>I love building apps</p>

            <a href="">hello@amane.dev</a>
        </div>
    </section>
    <section id="projects" class="py-5 bg-gray-100 ">
        <div class="container width flex justify-center">
            <div class="flex justify-between">
                {{-- @for ($i = 0; $i < 5; $i++) --}}
                <div class="rounded md:rounded-md w-20 h-20 md:w-24 md:h-24 bg-gray-300 hover:bg-gray-400 cursor-pointer overflow-hidden">
                    <a href="{{route('app-estimation')}}">
                        <img class="rounded md:rounded-md object-contain" src="/img/calc.jpg" alt="Estimate my app">
                    </a>
                </div>
                {{-- @endfor --}}

                <a href="{{route('new-project')}}" class=" relative mr-2 ml-10 rounded md:rounded-md w-20 h-20 md:w-24 md:h-24 bg-gray-300 hover:bg-gray-400 cursor-pointer p-5 flex justify-center items-center">

                    <i class="material-icons">add</i>
                </a>
            </div>
        </div>
    </section>
    <section id="contacts" class="py-5 bg-white ">
        <div class="container width flex justify-center">
            <div class="flex justify-between">

                <a x-data="{tooltip:false}" x-on:mouseover="tooltip = true" x-on:mouseleave="tooltip = false" class=" relative mr-2 bg-gray-300 hover:bg-gray-400  p-5 flex justify-center items-center rounded-full w-16 h-16 md:w-20 md:h-20  cursor-pointer" >
                    <div class="relative" x-cloak x-show.transition.origin.top="tooltip">
                        <div style="z-index: 999" class="absolute bg-white top-0 z-50 w-32 p-2 text-sm leading-tight text-black transform -translate-x-1/2 -translate-y-1/2 bg-orange-500 rounded-lg shadow-lg text-center">
                            I'm an introvert, please please mail me instead TT
                        </div>
                    </div>
                    <i class="material-icons text-gray-500 text-3xl md:text-4xl">phone</i>
                </a>
                <div class="rounded-full ml-10 w-16 h-16 md:w-20 md:h-20 bg-gray-300 hover:bg-gray-400 cursor-pointer p-5 flex justify-center items-center">
                    <a href="mailto:hello@amane.dev" target="_blank">
                        <i class="material-icons text-gray-500 text-3xl md:text-4xl">email</i>
                    </a>
                </div>
            </div>
        </div>
    </section>
    <footer class="text-center bg-gray-700 text-white py-32" title="Amane Hosanna">
        <div>

            あ

        </div>
    </footer>
</main>
@endsection

@extends('layouts.app')

@section('title', 'Demander devis')

@section('locale', 'fr')

@section('styles')
    <style>
        input[type="checkbox"][id^="data"] {
            display: none;
        }

    </style>
@endsection

@section('content')
    <main class="font-medium bg-gray-100 flex flex-col h-full">
        <nav class="width flex flex-col justify-between items-center">
            <a href="/" class="font-bold">
                Amane.dev
            </a>
        </nav>
        <div class="width text-center">
            <h1>Demande de devis</h1>
            <div>
                {{-- Veuillez --}}
            </div>
        </div>
        {{-- Client Quote Request Page --}}
        {{-- Client info --}}
        <section class="p-10">
            
        </section>
        {{-- <livewire:client-quote-request-form /> --}}
        <section class="p-10">
            <article class="bg-white rounded-md shadow-sm text-center p-5">
                <h3>1. Quelle est la taille de votre application</h3>
                <div class="flex justify-between">
                    <div class="flex-col p-3">
                        <label for="input_small" class="">
                            <div>
                                Petite
                            </div>
                            <input hidden class="hidden" type="radio" id="input_small"  wire:model="data.app_size" value="small">
                            <div class="mt-3 relative cursor-pointer rounded-full border-8 border-green-500">
                                <img class="absolute" src="/images/icons/icon-ok-48.png" alt="">
                                <img src="/images/quote/small.png"  class="w-44 h-44 rounded-full" alt="">
                            </div>
                        </label>
                    </div>
                </div>
            </article>
        </section>

        {{-- <footer class="py-10 text-center bg-gray-500 text-white">
            <div class="width rounded  px-5">
                Copyright (c) 2021 {{env('APP_NAME')}} Côté d'Ivoire. All Rights Reserved.
            </div>
        </footer> --}}
    </main>
@endsection

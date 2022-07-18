
<style>
    html, body{
        height: 100vh !important;
    }
</style>
<div class="h-full">
    {{-- To attain knowledge, add things every day; To attain wisdom, subtract things every day --}}
    <section class="width h-full flex flex-col justify-center">

        <div class="text-center h-64 overflow-hidden rounded md:rounded-md  mx-10 md:mx-20">
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

            <img src="{{$img}}" alt="" class="w-2/3 md:w-1/2 mx-auto h-auto rounded md:rounded-md">
        </div>
        <div class="text-center md:pt-5 text-xl">
            <a href="/" class="">
                @if($coding)
                    I'm working on it
                @else
                    I'm not working on it
                @endif
            </a>

        </div>
    </section>
</div>

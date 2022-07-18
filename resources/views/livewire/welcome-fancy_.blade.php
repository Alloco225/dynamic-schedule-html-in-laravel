


<style>
    html, body{
        height: 100vh;
    }
    .bg-stars{
        background-image: url('/emoji/sparkle.png');
        background-size: 50px;
    }
    .bg-hero{
        background-image: url('/e/sparkle.png'),url('/e/sparkle.png'), url('/e/sun_sunny.png');
        background-size: 20px, 30px;
        background-position: 10px 20px, 50px 30px;
        background-repeat: no-repeat;
    }

    .blue-tile{

    }
</style>

<div class="h-96 lg:h-4/6 bg-hero relative bg-gray-50">
    {{-- <div>
        <img src="/e/sparkle.png" alt="">
    </div> --}}
    <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-red-400 w-full">
        <div class="blue-box bg-blue-500 h-56 md:h-96 w-8/12 absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 -skew-x-6">
        </div>
        <div class="blue-box bg-yellow-500 h-48 md:h-80 w-8/12 absolute top-1/3 left-2/4 transform -translate-x-2/4 -translate-y-3/4 -skew-x-12">
        </div>
        <div class="text-3xl">
            Hello, <div>Amane Hosanna</div>
        </div>
    </div>
</div>

<script>
    var bgHero = document.querySelector('.bg-hero');
    var starCount = 23;
    var height = bgHero.style.height;
    var width = bgHero.style.width;
    var starUrl = 'e/sparkle.png';
    var maxSize = '40px';
    for(var i = 0; i < starCount; i++){
        size
    }
</script>

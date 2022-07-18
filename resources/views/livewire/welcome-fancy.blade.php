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

    .bg-tile{

    }
    .blue-tile{

    }
</style>

<div class="h-96 lg:h-4/6 bg-hero relative bg-gray-50">
    {{-- <div>
        <img src="/e/sparkle.png" alt="">
    </div> --}}
    <div class="bg-tile">
        <div class="blue-tile">
        </div>
        <div class="yellow-tile">
        </div>
        <div class="red-tile">
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

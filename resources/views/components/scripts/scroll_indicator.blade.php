<script>
    console.log("<<< scrollIndicator();");

// When the user scrolls the page, execute scrollIndicator
    window.onscroll = function() {scrollIndicator()};

    function scrollIndicator() {
    var winScroll = document.body.scrollTop || document.documentElement.scrollTop;
    var height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
    var scrolled = (winScroll / height) * 100;
    document.getElementById("scroll_progressbar").style.height = scrolled + "%";
    }
</script>

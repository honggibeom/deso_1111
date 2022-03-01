(function(){
    function homeBannerFn(){
        const bannerSwiper = new Swiper(".banner__area", {
            loop: true,
            speed : 800,
            autoplay: {
                delay: 3000
            }
        });
    };
    homeBannerFn();
})();



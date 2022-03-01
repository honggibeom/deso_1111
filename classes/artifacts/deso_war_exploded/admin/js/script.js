;(function(d, $){
	
    //=================================================================================== 사이드 레이아웃
    function asideFn(){
        const $navBtn = $('.nav-toggle');
        const $nav = $('.nav');
        const $depthItem = $('.depth-link');

        $navBtn.click(function(e){
            e.preventDefault();
            $nav.slideToggle();
            
        });

        $depthItem.click(function(e){
            e.preventDefault();
            $(this).parent().next('.nav-depth').slideToggle();
        });

        $(window).resize(function(e){
            if($(this).innerWidth() > 1024) $nav.css({'display' : 'block'});
            else $nav.css({'display' : 'none'});
        });

    };asideFn();

   
     //=================================================================================== 이미지 용량 체크, 이미지 삭제

    function imgLoadFn(){
        $('.img-small').change(function(e){
            let maxSize = 3 * 1024 * 1024,
                fileSize = $(this)[0].files[0].size;
            if(fileSize > 0 && fileSize > maxSize){
                alert("이미지 파일 용량이 커서 등록되지 않습니다. 3M 이하로 등록해주세요.");
                $(this).val('');
            } 
        });

        $('.img-del').click(function(e){
            e.preventDefault();
            let $input = $(this).parent().find('input');
            if($input && $input.val()) $input.val('');
            return;
        });

    };imgLoadFn();

    //=================================================================================== 전체 삭제 체크박스
    function checkAllFn(inputCheck){
        inputCheck.change(function(e){
            e.preventDefault();
            let $checks = $(this).parents('table').find('tbody input[type="checkbox"]');
            if($(this).is(':checked')) $checks.prop('checked', true);
            else $checks.prop('checked', false);
        });
    };
    if($('form thead input[type="checkbox"]').length > 0) checkAllFn($('form thead input[type="checkbox"]'));

    //=================================================================================== flatpickr
    function datePickerFn(inputDate){
        inputDate.flatpickr({
            "locale" : "ko",
            dateFormat: "Y년 m월 d일",
            disableMobile: "true"
        }); 
    };
    if($('.date-picker').length > 0) datePickerFn($('.date-picker'));


})(document, jQuery);
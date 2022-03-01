;(function(d){

    // 비회원(비로그인 회원, 비인증 회원) 방문시 진입 방지 스크립트
    function guestModeFn(){
        var clickable = d.querySelector('#main').querySelectorAll('a, button'),
            modal = d.querySelector('.modal');

        clickable.forEach(el => {
            el.addEventListener('click', function(e){
                e.preventDefault();
                e.stopPropagation();
                if(!modal.classList.contains('is-activate')){
                    modal.classList.add('is-activate');
                    modal.closest('.layer').classList.add('is-activate');
                } else {
                    modal.classList.remove('is-activate');
                    modal.closest('.layer').classList.remove('is-activate');
                }
            });
        });
    };
    if(d.querySelector('#main').classList.contains('guest')) guestModeFn();

    // 탭 기능 스크립트
    // function tabFn(){
    //     var tabs = document.querySelectorAll('.tab');
    //     var activate = 'is-activate';

    //     tabs.forEach(tab => {
    //         tab.querySelectorAll('.tab__navs__nav').forEach(nav => {
    //             nav.addEventListener('click', switchTab);
    //         })
    //     });
    //     function switchTab(event){
    //         var nav = event.target;
    //         if(nav.classList.contains(activate)){
    //             return;
    //         } else {
    //             var tab = nav.closest('.tab'),
    //                 data = nav.dataset.tab,
    //                 activated = tab.querySelectorAll('.'+activate);

    //             activated.forEach(el => {
    //                 el.classList.remove(activate);
    //             });
                
    //             nav.classList.add(activate);
    //             tab.querySelector('.tab__contents__cont[data-tab="'+ data +'"]').classList.add(activate);
    //         }
    //     };
    // };
    // if(d.querySelectorAll('.tab').length > 0) tabFn();

    // 레이어 모달 스크립트
    function modalFn() {
        var modalControlls = document.querySelectorAll('.modalControll');
        var modalCloses = document.querySelectorAll('.modalClose');
        var layer = document.querySelector('.layer');
        var activate = 'is-activate';
        var isActivated = true;

        modalControlls.forEach(el => {
            el.addEventListener('click', showModal);
        });

        modalCloses.forEach(el => {
            el.addEventListener('click', hideModal);
        });

        function showModal(event){
            var modalData = event.target.dataset.modal;
            var modal = document.querySelector('.modal[data-modal="'+ modalData +'"]');
            var layer = modal.closest('.layer');
            var modalClose = modal.querySelector('.modalClose');
            
            if(modal){
                modal.classList.add(activate);
                layer.classList.add(activate);
                if(modalClose)modalClose.addEventListener('click', hideModal);
                handleLayerClick(isActivated);
            }
        };

        function hideModal(event){
            event.preventDefault();
            event.target.closest('.layer').classList.remove(activate);
            event.target.closest('.modal').classList.remove(activate);
        };

        function hideLayer(event){
            var clicked = event.target;
            var modal = layer.querySelector('.is-activate');

            if(clicked.closest('.modal') || clicked.classList.contains('modal')) return;
            else if(clicked.closest('.modalControll') || clicked.classList.contains('modalControll')) return;
            else {
                modal.classList.remove(activate);
                layer.classList.remove(activate);
                handleLayerClick(!isActivated);
            }
        };

        function handleLayerClick(isActivated){
            if(isActivated) document.addEventListener('click', hideLayer);
            else document.removeEventListener('click', hideLayer);
        };
		
    }; 
    if(d.querySelectorAll('.modal').length > 0) modalFn();


    // 메뉴 스크립트 
    function deptMenuFn(){
        var depthMenuBtn = document.querySelector('.depthControll');
        var depthMenu = document.querySelector('.depthMenu');
        var activate = 'is-activate';
        var isActivated = true;

        depthMenuBtn.addEventListener('click', function(event){
            depthMenu = event.target.closest('.menu').querySelector('.depthMenu');
            if(!depthMenu.classList.contains(activate)) showMenu();
            else hideMenu();
        });

        function showMenu(){
            depthMenu.classList.add(activate);
            handleWindowClick(isActivated);
        };

        function hideMenu(){
            depthMenu.classList.remove(activate);
            handleWindowClick(!isActivated);
        };

        function handleWindowClick(isActivated){
            if(isActivated) document.addEventListener('click', hideDepthMenu);
            else document.removeEventListener('click', hideDepthMenu)
        };

        function hideDepthMenu(event){
            let clicked = event.target;
            if(clicked.closest('.depthControll') || clicked.classList.contains('depthControll')) return; //clicked = depthBtn
            else if(clicked.closest('.depthMenu') && clicked.classList.contains('depthMenu')) return; //clicked = depthMenu
            else hideMenu();
        };
    }
    if(d.querySelectorAll('.depthMenu').length > 0) deptMenuFn();


    // 이미지 로드 스크립트
    function imgloadFn(){
        var imgloadBtns = d.querySelectorAll('.imgload__cont__btn');

        imgloadBtns.forEach(btn => {
            btn.addEventListener('click', handelClickBtn);
        });

        function handelClickBtn(event) {
            var imgload = event.target.closest('.imgload');
            var img = imgload.getElementsByTagName("img");
            if(img.length > 0) {
                delImg(event);
            } else {
                var input = event.target.nodeName === "INPUT" ? event.target : event.target.getElementsByTagName('input')[0];
                input.addEventListener('change', addImg);
            }
        };
        
        function changeBtn(btn){
            if(btn.classList.contains('add')) {
                btn.classList.remove('add');
                btn.classList.add('del');
            } else {
                btn.classList.add('add');
                btn.classList.remove('del');
            }
        };

        function delImg(event){
            event.preventDefault();
            var imgload = event.target.closest('.imgload');
            var label = imgload.getElementsByTagName('label')[0];
            imgload.getElementsByTagName('img')[0].remove();
            imgload.getElementsByTagName('input')[0].value="";
			imgload.getElementsByTagName('input')[1].value="";
            changeBtn(label);
            //sortEmpty(imgload);
        };

        function addImg(event){
            var maxSize = 3 * 1024 * 1024;
            if(event.target.files[0].size > maxSize ) {
                toast('error',"이미지 파일 용량이 커서 등록되지 않습니다. 3MB 이하로 등록해주세요.");
                return false;
            } else {
                var input = event.target;
                var imgload = input.closest('.imgload');
                var label = input.nextElementSibling;
    
                var fReader = new FileReader();
                fReader.onload = function(event){
                    var img = d.createElement('img');
                    img.setAttribute('src', event.target.result);
                    img.classList.add('imgload__cont__img')
                    imgload.querySelector('.imgload__cont').appendChild(img);
                };
                fReader.readAsDataURL(input.files[0]);
    
                changeBtn(label);
                sortImg(imgload);
            };
        };

        function sortImg(imgload){
            var thisImg = imgload;
            var imgList = thisImg.closest('.imgloads');
            var prevImg = thisImg.previousElementSibling;
            if(prevImg) {
                if(prevImg.getElementsByTagName('img').length > 0) {
                    return;
                }
                else {
                    imgList.insertBefore(thisImg, prevImg);
                    sortImg(imgload);
                }
            }
        };

        function sortEmpty(imgload){
            let thisImg = imgload;
            let imgList = thisImg.closest('.imgloads');
            let nextImg = thisImg.nextElementSibling;
            if(nextImg) {
                if(nextImg.getElementsByTagName('img').length <= 0) {
                    return;
                }
                else {
                    imgList.insertBefore(nextImg, thisImg);
                    sortEmpty(imgload);
                }
            }
        };

    };
    if(d.querySelectorAll('.imgload').length > 0) imgloadFn();

    // 셀렉트(/옵션) 스크립트
    function selectBoxFn(){

        var selectBoxes = d.querySelectorAll('.selectbox');
        var isOn = true;

        selectBoxes.forEach(el => {
            var select = el.querySelector('.selectbox__select');
            var options = el.querySelectorAll('.selectbox__option__item');
            select.addEventListener('click', clickSelect);
            options.forEach(opt =>{
                opt.addEventListener('click', clickOption);
            })
        });

        function clickSelect(event) {
            event.preventDefault();
            var option = event.target.closest('.selectbox').querySelector('.selectbox__option');
            if(!option.classList.contains('is-on')) {
                hideAllOptions();
                option.classList.add('is-on');
                handleWindowClick(isOn);
            }
            else {
                option.classList.remove('is-on');
                handleWindowClick(!isOn);
            }
        }

        function hideAllOptions(){
            var options = d.querySelectorAll('.selectbox__option.is-on');
            if(options){
                options.forEach(el =>{
                    el.classList.remove('is-on');
                })
            }
        };

        function clickOption(event){
            event.preventDefault();
            var value = event.target.dataset.option;
            var input = event.target.closest('.selectbox').querySelector('.selectbox__select');
            input.value = value;
            event.target.closest('.selectbox__option').classList.remove('is-on');
            handleWindowClick(!isOn);
        };

        function handleWindowClick(isOn){
            if(!isOn) window.removeEventListener('click', hideSelect);
            else window.addEventListener('click', hideSelect)
        };

        function hideSelect(event){
            var clicked = event.target;
            var optionOn = d.querySelector('.is-on');
            if(clicked.closest('.selectbox') || clicked.classList.contains('selectbox')) return;
            else {
                optionOn.classList.remove('is-on');
                handleWindowClick(!isOn)
            }
        };
    };
    if(d.querySelectorAll('.selectbox').length > 0) selectBoxFn();

})(document);
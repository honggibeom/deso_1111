<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../../header.jsp" flush="false" />
    <div class="layer">
        <div class="modal" data-modal="noResult">
            <h5 class="modal__title">검색 결과 없음</h5>
            <p class="modal__text">
                입력하신 주소에 대한 검색 결과가 없습니다.
            </p>
            <button type="button" class="btn btn--submit modalClose">다시 검색 하기</button>
        </div>
    </div>
    <div id="app">
        <main id="main">
            <section class="section meet meet-filter">
                <div class="section__top fixed">
                    <h2 class="section__top__title center">위치</h2>
                    <div class="section__top__menu menu">
                        <div class="menu__group">
                            <a href="javascript:history.back()" class="menu__group__prev"></a>
                        </div>
                    </div>
                </div>
                <div class="section__content">
                    <form class="filter">
                        <fieldset class="field filter__field" style="position: relative; z-index: 14;">
                            <label for="fLoc01" class="label">위치</label>
                            <div class="selectbox">
                                <input type="text" name="fLoc01" id="fLoc01" class="selectbox__select bg" placeholder="지역을 선택해 주세요." readonly required>
                                <ul class="selectbox__option">
                                    <li class="selectbox__option__item" data-option="천안">천안</li>
                                    <li class="selectbox__option__item" data-option="아산">아산</li>
                                </ul>
                            </div>
                        </fieldset>
                        <fieldset class="field filter__field search">
                            <label for="fLoc" class="label label--s">동위치 입력</label>
                            <div class="search__wrap">
                                <input type="text" name="fLoc" id="fLoc" class="bg" placeholder="예) 쌍용동" value="" required>
                                <!-- <button type="submit" class="icon icon--search btn"></button> -->
                                <button type="button" class="icon icon--search btn modalControll" data-modal="noResult"></button>
                            </div>
                        </fieldset>
                        <div class="actions">
                            <!-- <button type="button" class="actions__submit">확인</button> -->
                            <a href="${pageContext.request.contextPath}/mypage/account/edit/edit_profile.jsp" class="actions__submit">확인</a>
                        </div>
                    </form>
                </div>
            </section>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</hml>
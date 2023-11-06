// Swiperのオプションを定数化((((スライドショーのためにファイル作成))))

// 一度だけマウスが置かれた時にアラートを表示しろ
let alertShown = false;
$(function(){
  $('.swiper').mouseover(function(){
    if (!alertShown) {
      let title = "こちらは全てイメージです。";
      alert(title);
      alertShown = true;
    }
  });
});
// ここまで

$(function() {
  $('#back a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 1000);
    event.preventDefault();
  });
});

const opt = {
  loop: true,
  pagination: {
    el: '.swiper-pagination',
  },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  }
}

// Swiperを実行(初期化)
$(document).on('turbolinks:load', function() {
    let swiper = new Swiper('.swiper',opt);
});

$(function(){
  $('#partial-template').on('click',function(){
    $('#partial-template').css({
      'display': 'none',
    }).slideUp();
  });
});

// // イベントを監視する要素を取得
// const targetElement = document.getElementById('target-element'); // マウスオーバーをトリガーする要素
// const partialTemplate = document.getElementById('partial-template'); // 部分テンプレートの要素
// const closeButton = document.getElementById('close-partial-template'); // 部分テンプレートを閉じるボタン

// // マウスオーバー時の処理
// targetElement.addEventListener('mouseover', () => {
//   // 部分テンプレートを表示
//   partialTemplate.style.display = 'block';
// });

// // 部分テンプレートを閉じる処理
// closeButton.addEventListener('click', () => {
//   partialTemplate.style.display = 'none';
// });
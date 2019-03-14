$(document).on('click', "[data-behavior~=reply-link]", function () {
  event.preventDefault()
  $('#' + this.dataset.target).show('fast')
});

$(document).on('click', "[data-behavior~=see-more]", function () {
  event.preventDefault()

  var target = $('#' + this.dataset.target)
  if (target.css('max-height') == "130px") {
    target.css("max-height", "10000px");
    target.css("min-height", "150px");
    target.css("padding-bottom", "50px");
    this.innerHTML = "<i class='fa fa-minus'></i> Ver menos"
  } else {
    target.css("max-height", "130px");
    target.css("min-height", "0px");
    target.css("padding-bottom", "0px");
    this.innerHTML = "<i class='fa fa-plus'></i> Ver más"
  }
});

$(document).on('keypress', "#forum_post_body", function (e) {
  if (e.keyCode == 13) {
    if (e.shiftKey) {
      this.value = content.substring(0, caret - 1) + "\n" + content.substring(caret, content.length);
      event.stopPropagation();
    } else {
      console.log(this);
      this.closest('form').submit();
    }
    return false;
  }
});

$(document).ready(function () {
  var cards = document.getElementsByClassName('forum-post');
  var l = cards['length']
  console.log(l);

  for (i = 0; i < l; i++) {

    if (cards[i].offsetHeight < 115) {
      console.log(cards[i].offsetHeight);

      $(cards[i]).find('.diffuse').hide()
    }
  }
});


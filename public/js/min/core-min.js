$(window).load(function(){$(".anima").waypoint(function(){$(this).addClass("in")},{offset:"95%"})}),$(document).ready(function(){function a(){var a=$("#hero"),t=$(window),h=a.data("height");a.css(a.hasClass("full-height")?{height:t.height()}:{height:h+"em"})}$(".parallax").parallax(),$(".smooth-scroll").click(function(){if(location.pathname.replace(/^\//,"")===this.pathname.replace(/^\//,"")&&location.hostname===this.hostname){var a=$(this.hash);if(a=a.length?a:$("[name="+this.hash.slice(1)+"]"),a.length)return $("html,body").animate({scrollTop:a.offset().top},1e3),!1}}),a(),$(window).resize(a)});
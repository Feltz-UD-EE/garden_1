// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require foundation
//= require jquery-ui/datepicker
//= require jquery-ui/slider
//= require jquery.timepicker
//= require jquery-ui-timepicker-addon
//= require dataTables/jquery.dataTables
//= require dataTables/jquery.dataTables.foundation
//= require dataTables/extras/dataTables.responsive

//= require_tree .

"use strict"

$(document).foundation().foundation('abide', {
  timeout: 30000,
  patterns: {
    email: /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
    phone_number: /^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/,
    zip_code: /^\d{5}(?:[-\s]\d{4})?$/,
    password: /.{8,}/,
    name_part: /^([a-zA-Z][ '-.]?)+$/,
    pos_numeric: /^([\d][.]?)+$/
  }
});

/* Monkey patch for Foundation topbar toggle functionality. Disabled breakpoint() function as
   the Ocean styles do not require a breakpoint check, as the hamburger icon is only being shown at smaller resolutions.
*/

    Foundation.libs.topbar.toggle = 
    function() {
      var self = this;
      var topbar = $('.top-bar, [data-topbar]'),
          section = topbar.find('section, .section');

      // this is to override the breakpoint functionality, as our styles don't require a check for this.
      if (self.breakpoint() || true) {
        if (!self.rtl) {
          section.css({left: '0%'});
          section.find('>.name').css({left: '100%'});
        } else {
          section.css({right: '0%'});
          section.find('>.name').css({right: '100%'});
        }

        section.find('li.moved').removeClass('moved');
        topbar.data('index', 0);

        topbar
          .toggleClass('expanded')
          .css('height', '');
      }

      if(self.settings.scrolltop)
      {
        if (!topbar.hasClass('expanded')) {
          if (topbar.hasClass('fixed')) {
            topbar.parent().addClass('fixed');
            topbar.removeClass('fixed');
            $('body').addClass('f-topbar-fixed');
          }
        } else if (topbar.parent().hasClass('fixed')) {
          if (self.settings.scrolltop) {
            topbar.parent().removeClass('fixed');
            topbar.addClass('fixed');
            $('body').removeClass('f-topbar-fixed');

            window.scrollTo(0,0);
          } else {
              topbar.parent().removeClass('expanded');
          }
        }
      } else {
        if(topbar.parent().hasClass(self.settings.stickyClass)) {
          topbar.parent().addClass('fixed');
        }

        if(topbar.parent().hasClass('fixed')) {
          if (!topbar.hasClass('expanded')) {
            topbar.removeClass('fixed');
            topbar.parent().removeClass('expanded');
            self.updateStickyPositioning();
          } else {
            topbar.addClass('fixed');
            topbar.parent().addClass('expanded');
          }
        }
      }
    };

#
# Copyright 2015-2016 Prehab Technologies LLC dba prenovo.  All rights reserved.
#

# replaces icons in action column of responsive tables with explicit text button, because hover-over doesn't work on touch devices

if !$('html').hasClass('no-touch')
  $('span#edit').replaceWith '<button class="responsive-button">Edit</button>'
  $('span#log').replaceWith '<button class="responsive-button">Log</button>'
  $('span#suspend').replaceWith '<button class="responsive-button">Suspend</button>'
  $('span#delete').replaceWith '<button class="responsive-button">Delete</button>'
  $('span#recover').replaceWith '<button class="responsive-button">Recover</button>'
  $('span#manage').replaceWith '<button class="responsive-button">Manage</button>'
  

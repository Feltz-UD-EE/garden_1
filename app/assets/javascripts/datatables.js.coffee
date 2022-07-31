#
# Copyright 2015-2016 Prehab Technologies LLC dba prenovo.  All rights reserved.
#

#
# configures layout & behavior of Datatables plug-in for smart tables.
#
jQuery ->
  $('table#patients').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'
    columnDefs: [
     { orderable: false, targets: -1 }
    ]

     
  $('table#careteams').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'
    "columns": [
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      { "width": "110px", "orderable": false }      
    ]

  $('table#admins').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'
    "columns": [
      null,
      null,
      null,
      { "width": "20em" }      
      null,
      { "width": "115px", "orderable": false }      
    ]
 
  $('table#assessments').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'
  
  $('table#pedometer').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'
   
  $('table#spirometer').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#brand_monthly_patient').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'
  
  $('table#brand_monthly_assessment').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#brand_monthly_library').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#brand_weekly_1').dataTable
    "language": {
      "search": "Filter:"
    }
    bSort : false
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#brand_weekly_2').dataTable
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#brand_weekly_3').dataTable
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#patient_measurements').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'
    
  $('table.users').dataTable
    "language": {
      "search": "Filter:"
    }
    responsive: true
    bAutowidth: false  
    "columnDefs": [ {
      "searchable": false, "orderable": false, "targets": [7]
    } ]

  $('table#phone_polls').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#inbound_texts').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#outbound_texts').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#logs').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'
#
# following 3 are all on 1 page (views/preregistrations/action_table.html.erb)
#
  $('table#to_be_enrolled').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#invitations').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#completed_preregistrations').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#recent_patients').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'
# 
# (views/preregistrations/expired_archive_table.html.erb)
#   
  $('table#expired_invites').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

#
# /views/analyses
#
  $('table#analysis_succeeded').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#analysis_succeeded_short').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#analysis_inprocess').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'
    
  $('table#analysis_failed').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'
    
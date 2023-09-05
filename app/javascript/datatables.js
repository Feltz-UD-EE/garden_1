#
# configures layout & behavior of Datatables plug-in for smart tables.
#
jQuery ->
  $('table#public-zones').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'
    columnDefs: [
     { orderable: false, targets: -1 }
    ]


  $('table#public-tanks').dataTable
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

  $('table#tanks').dataTable
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

  $('table#tank-zones').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#tanks-levels').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#zones').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#zone-crops').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#zone-events').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#zone-moistures').dataTable
    "order": []
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#crops').dataTable
    "language": {
      "search": "Filter:"
    }
    bSort : false
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#crop-events').dataTable
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'

  $('table#events').dataTable
    "language": {
      "search": "Filter:"
    }
    aLengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    dom: '<"top"f>rt<"bottom"pil><"clear">'


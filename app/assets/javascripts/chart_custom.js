if (typeof tempbarchartnamearray !== 'undefined') {
  var barChartData = {
	labels : tempbarchartnamearray,
	datasets : [
		{
			fillColor : "rgba(151,187,205,0.5)",
			strokeColor : "rgba(151,187,205,0.8)",
			highlightFill : "rgba(151,187,205,0.75)",
			highlightStroke : "rgba(151,187,205,1)",
		    data: barchartdataarray,
		}
	]
  };
}
  
if (typeof patientstatepiechart !== 'undefined') {
  patientstatepiechart[0].color = "#ff7b00";
  patientstatepiechart[0].highlight = "#ff9533";
  patientstatepiechart[1].color = "#46BFBD";
  patientstatepiechart[1].highlight = "#5AD3D1";
  patientstatepiechart[2].color = "#FDB45C";
  patientstatepiechart[2].highlight = "#FFC870";
  if (patientstatepiechart.length == 4) {
    patientstatepiechart[3].color = "#949FB1";
    patientstatepiechart[3].highlight = "#A8B3C5";
  }
  var pieData = patientstatepiechart;
}

if (typeof assessmentstatepiechart !== 'undefined') {
  assessmentstatepiechart[0].color = "#F7464A";
  assessmentstatepiechart[0].highlight = "#FF5A5E";
  assessmentstatepiechart[1].color = "#FDB45C";
  assessmentstatepiechart[1].highlight = "#FFC870";
  assessmentstatepiechart[2].color = "#4D5360";
  assessmentstatepiechart[2].highlight = "#616774";
  assessmentstatepiechart[3].color = "#46BFBD";
  assessmentstatepiechart[3].highlight = "#5AD3D1";

  var pieData2 = assessmentstatepiechart;
}

if (document.getElementById('barchart') !== null) {
  var ctx = document.getElementById("barchart").getContext("2d");
  var myBar = new Chart(ctx).Bar(barChartData, {
	responsive : false,
	maintainAspectRatio: false,
	barValueSpacing : 2,
	barStrokeWidth : 2,
	barDatasetSpacing : 5,
	scaleOverride : true,
    scaleSteps : 4,
    scaleStepWidth : 25,
    scaleStartValue : 0 ,
  });
}

if (document.getElementById('piechart1') !== null) {
  var ctx_1 = document.getElementById("piechart1").getContext("2d");
  var myPie1 = new Chart(ctx_1).Doughnut(pieData,{
	responsive : false,
	// tooltipFontSize: 12,
	// tooltipCaretSize: 0,
	percentageInnerCutout: 0,
	tooltipTemplate: "<%= value %>",
  legendTemplate : 
    '<ul>'
      +'<% for (var i=0; i<pieData.length; i++) { %>'
        +'<li><a href=\"patients/dashboard_list?careteam=<%=pieData[i].careteam%>&scope=<%=pieData[i].scope%>&label=<%=pieData[i].label%>\"">'
          +'<span style=\"background-color:<%=pieData[i].color%>\"></span>'
          +'<% if (pieData[i].label) { %>'
            +'<%= pieData[i].label %>'
          +'<% } %>'
        +'</a></li>'
      +'<% } %>'
    +'</ul>'
  });
  document.getElementById('js-legend').innerHTML = myPie1.generateLegend();
}

if (document.getElementById('piechart2') !== null) {
  var ctx_2 = document.getElementById("piechart2").getContext("2d");
  var myPie2 = new Chart(ctx_2).Doughnut(pieData2,{
	responsive : false,
	// tooltipFontSize: 12,
	// tooltipCaretSize: 0,
	percentageInnerCutout: 0,
	tooltipTemplate: "<%= value %>",
  legendTemplate : 
    '<ul>'
      +'<% for (var i=0; i<pieData2.length; i++) { %>'
        +'<li><a href=\"patients/dashboard_list?careteam=<%=pieData2[i].careteam%>&scope=<%=pieData2[i].scope%>&label=<%=pieData2[i].label%>\"">'
          +'<span style=\"background-color:<%=pieData2[i].color%>\"></span>'
          +'<% if (pieData2[i].label) { %>'
            +'<%= pieData2[i].label %>'
          +'<% } %>'
        +'</a></li>'
      +'<% } %>'
    +'</ul>'
  });
  document.getElementById('js-legend2').innerHTML = myPie2.generateLegend();
}



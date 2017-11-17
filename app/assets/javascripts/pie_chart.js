var pieChart = function(values, labels, colours) {
  var data = [{
    values: values,
    labels: labels,
    marker: {
      colors: colours
    },
    type: 'pie',
    hoverinfo: 'label',
    bgcolor: 'transparent'
  }];

  var layout = {
    height: 300,
    width: 300,
    paper_bgcolor: 'rgba(0,0,0,0)',
    plot_bgcolor: 'rgba(0,0,0,0)',
    showlegend: false,
    margin: {
      l: 10,
      r: 10,
      b: 10,
      t: 10,
      pad: 4
    },
  };

  Plotly.newPlot('pie', data, layout, {
    displayModeBar: false
  });
}

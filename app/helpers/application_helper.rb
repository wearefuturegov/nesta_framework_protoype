module ApplicationHelper
  
  def pie_chart(hash)
    values = hash.values.join(',')
    labels = hash.keys
    """
    <div id='pie'></div>
    <script>
      var data = [{
        values: [#{values}],
        labels: [#{labels.map { |k| "'#{k}'" }.join(',')}],
        marker: {
          colors: [#{colours_for(labels)}]
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
    </script>
    """.html_safe
  end
  
  def colours_for(labels)
    labels.to_a.map { |l| "'#{Area.find_by(name: l).colour}'" }.join(',')
  end
  
end

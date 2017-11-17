module PieChartHelper
  
  def pie_chart(hash)
    """
      <div id='pie'></div>
      <script>
        pieChart([#{values(hash)}], [#{labels(hash)}], [#{colours(hash)}]);
      </script>
    """.html_safe
  end
  
  def values(hash)
    hash.values.join(',')
  end
  
  def labels(hash)
    hash.keys.map { |k| "'#{k}'" }.join(',')
  end
  
  def colours(hash)
    hash.keys.map { |l| "'#{Area.find_by(name: l).colour}'" }.join(',')
  end
  
end

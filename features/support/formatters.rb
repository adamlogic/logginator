module Formatters

  def summary_time_format(time)
    time.strftime('%m/%d %H:%M:%S')
  end

  def detail_time_format(time)
    time.strftime('%b %e, %Y %H:%M:%S')
  end

end

World(Formatters)

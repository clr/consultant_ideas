# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def nice_date( datetime )
    datetime.strftime( "%m.%d.%y %H:%M%p" ) unless datetime.nil?
  end

end

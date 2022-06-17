module ApplicationHelper

    def month_day_comma_year(datetime)

     datetime.strftime('%d %b, %Y')

    end

end

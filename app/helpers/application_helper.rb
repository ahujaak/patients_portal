module ApplicationHelper
  def sort_data(attr)
    # attr here is the attribute name on which we want to apply sorting
    case params[:sort_by]
    when 'asc'
      {
        url: params[attr] ? "/#{controller_name}?#{attr}=#{params[attr]}&sort_by=desc" : "/#{controller_name}?sort_by=desc",
        icon: 'fas fa-arrow-up'
      }
    when 'desc'
      {
        url: params[attr] ? "/#{controller_name}?#{attr}=#{params[attr]}&sort_by=asc" : "/#{controller_name}?sort_by=asc",
        icon: 'fas fa-arrow-down'
      }
    else
      # search and sort
      {
        url: params[attr] ? "/#{controller_name}?#{attr}=#{params[attr]}&sort_by=asc" : "/#{controller_name}?sort_by=asc",
        icon: 'fas fa-arrow-down'
      }
    end
  end
end

module ApplicationHelper
  def pluralize_count(count)
    return "No Articles" if count == 0
    count == 1 ? "1 Article" : "#{count} Articles"
  end
end

module ApplicationHelper

	def active_class(link_path)
  		current_page?(link_path) ? "active" : ""
 	end

 	def flash_class(level)
	    case level
	        when :notice then "alert alert-success"
	        when :success then "alert alert-success"
	        when :error, :danger then "alert alert-error"
	        when :alert then "alert alert-error"
	    end
	end
end

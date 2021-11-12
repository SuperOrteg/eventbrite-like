module AdminHelper

	def is_admin
		if current_user.admin == true
			return true
		else
			return false
		end
	end
end

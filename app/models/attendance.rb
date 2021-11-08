class Attendance < ApplicationRecord
	after_create :admin_send

	belongs_to :event
	belongs_to :user

	def admin_send
	    AttendanceMailer.admin_email(self.event.administrator).deliver_now
	end
end

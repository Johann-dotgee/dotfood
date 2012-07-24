User.all.each do |user|
	Reminder.reminder(user).deliver
end

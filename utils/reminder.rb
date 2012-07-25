User.all.each do |user|
  if (user.find_votes {:updated_at => Date.today}.blank?) || (EatAlone.find(user.id, :conditions => {:updated_at => Date.today}).blank?) do
	 Reminder.reminder(user).deliver
  end
end

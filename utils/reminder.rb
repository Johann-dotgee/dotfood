User.all.each do |user|
  votes = user.find_votes {:updated_at => Date.today}
  if (votes.blank?) || (EatAlone.find(user.id, :conditions => {:updated_at => Date.today}).blank?) do
	 Reminder.reminder(user).deliver
  end
end

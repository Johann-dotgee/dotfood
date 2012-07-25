User.all.each do |user|
  conditions = {:updated_at => Date.today}
  votes = user.find_votes conditions
  if (votes.blank?) || (EatAlone.find(user.id, :conditions => {:updated_at => Date.today}).blank?) do
	 Reminder.reminder(user).deliver
  end
end

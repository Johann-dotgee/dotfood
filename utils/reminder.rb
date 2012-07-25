User.all.each do |user|
  conditions = {:updated_at => Date.today}
  votes = user.find_votes conditions
  eat_alone = EatAlone.find(user.id, :conditions => {:updated_at => Date.today})
  if votes.blank? || eat_alone.blank?
	  Reminder.reminder(user).deliver
  end
end
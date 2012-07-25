User.all.each do |user|
  conditions = {:updated_at => Date.today}
  votes = user.find_votes conditions
  eat_alone = EatAlone.find(:conditions => {:updated_at => Date.today, :user_id => user.id})
  if votes.blank? || eat_alone.blank? do
	  Reminder.reminder(user).deliver
  end
end

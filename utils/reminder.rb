User.all.each do |user|
  conditions = {:updated_at => Date.today}
  votes = user.find_votes conditions
  eat_alone = EatAlone.all(:conditions => {:updated_at => Date.today, :user_id => user.id})
  if votes.blank? || eat_alone.blank?
	  Reminder.reminder(user).deliver
  end
end
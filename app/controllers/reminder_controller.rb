class ReminderController < ActionController::Base
  def dotreminder
    @user = User.all
    respond_to do |format|
      @user.each do |user|
        Reminder.reminder(user).deliver
        format.html
      end
    end
  end
end
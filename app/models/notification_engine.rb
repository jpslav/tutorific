class NotificationEngine

  def self.notify(notification_type, object=nil)
    notification =
      case notification_type
      when :registration_pending
        # RegistrationPendingNotification.new(object)
        #   which would call StudentMailer.registration_pending(student).deliver,
        #   add a notification to the in-site messages, etc
      else
        raise Error
      end

    notification.deliver
  end

end
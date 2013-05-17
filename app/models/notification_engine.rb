class NotificationEngine

  def self.notify(notification_type, object=nil)
    notification =
      case notification_type
      when :registration_pending
        # RegistrationPendingNotification.new(object)
      else
        raise Error
      end

    notification.deliver
  end

end
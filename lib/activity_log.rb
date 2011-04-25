module ActivityLog
  def self.included(base)
    base.send(:after_create,  :activity_create)
    base.send(:after_update,  :activity_update)
    base.send(:after_destroy, :activity_delete)
   
    def to_active
      {:attributes => attributes, :klass => self.class.to_s}
    end

    protected
    # Callbacks
    def activity_create
      ActivityLog::Activity.log_activity("created", self.to_active) if activity_tracking_enabled?
    end
    
    def activity_update
      ActivityLog::Activity.log_activity("updated", self.to_active) if activity_tracking_enabled?
    end
    
    def activity_delete
      ActivityLog::Activity.log_activity("deleted", self.to_active) if activity_tracking_enabled?
    end

    # Switchers
    def disable_activity_tracking!
      @activity_tracking_disabled = true
    end

    def enable_activity_tracking!
      @activity_tracking_disabled = false
    end

    def activity_tracking_enabled?
      !@activity_tracking_disabled
    end
  end
  
  class Activity
    include Mongoid::Document
    include Mongoid::Timestamps
    
    referenced_in :user

    field :action                   
    field :klass                    
    field :target, :type => Hash    
                                    
    def display
      return "#{target["name"].to_s}" if target["name"]
      return "#{target["title"].to_s}" if target["title"]
      return "#{target["description"].to_s}" if target["description"]
      return "#{target["_id"].to_s}"
    end

    def klass_name
      klass.to_s.downcase
    end

    # Class methods 
    class << self
      attr_accessor :current_user
      
      def clear_old
        # Clear activities that are more than 4 months old and use resque-scheduler to do this 
      end
      
      def log_activity(action, target)
        Activity.create(:action => action,
                        :user   => self.current_user,
                        :klass  => target[:klass], 
                        :target => target[:attributes])
      end
      
    end
  end
end

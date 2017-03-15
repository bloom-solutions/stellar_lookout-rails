module StellarLookout
  module ProcessingOperation
    class TriggerCallback

      extend LightService::Action
      expects :operation

      executed do |c|
        callback_class.(c.operation)
      end

      private

      def self.callback_class
        StellarLookout.configuration.on_receive.constantize
      end

    end
  end
end

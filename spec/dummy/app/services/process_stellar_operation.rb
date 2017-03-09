class ProcessStellarOperation

  def self.call(operation)
    Rails.logger.info "Woot got operation##{operation.id}"
  end
  
end

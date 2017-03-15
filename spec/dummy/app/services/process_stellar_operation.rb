class ProcessStellarOperation

  def self.call(operation)
    Rails.logger.info "Woot got operation##{operation.id}"
    Rails.logger.info "The transaction is #{operation.txn.external_id}"
  end

end

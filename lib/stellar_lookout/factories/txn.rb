FactoryGirl.define do

  factory :stellar_lookout_txn, class: "StellarLookout::Txn" do
    external_id { SecureRandom.hex }
    body { {id: "3389e9f0f1a65f19736cacf544c2e825313e8447f569233bb8db39aa607c8889"} }
  end

end

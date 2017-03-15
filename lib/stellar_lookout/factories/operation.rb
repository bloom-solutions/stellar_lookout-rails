FactoryGirl.define do

  factory :stellar_lookout_operation, class: "StellarLookout::Operation" do
    association :ward, factory: :stellar_lookout_ward
    association :txn, factory: :stellar_lookout_txn
    body { {id: "12884905985"} }
  end

end

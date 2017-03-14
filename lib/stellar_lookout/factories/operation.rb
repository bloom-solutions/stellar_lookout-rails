FactoryGirl.define do

  factory :stellar_lookout_operation, class: "StellarLookout::Operation" do
    association :ward, factory: :stellar_lookout_ward
  end

end

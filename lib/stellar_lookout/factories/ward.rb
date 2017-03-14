FactoryGirl.define do

  factory :stellar_lookout_ward, class: "StellarLookout::Ward" do
    address { SecureRandom.hex }
    secret { SecureRandom.uuid }
  end

end

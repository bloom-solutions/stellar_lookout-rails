FactoryGirl.define do

  factory :ward, class: "StellarLookout::Ward" do
    address { SecureRandom.hex }
    secret { SecureRandom.uuid }
  end

end

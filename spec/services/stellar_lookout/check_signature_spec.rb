require 'spec_helper'

module StellarLookout
  RSpec.describe CheckSignature do

    let(:ward) { build_stubbed(:ward, secret: SecureRandom.uuid) }
    let(:json) { {operation: "body"}.to_json }
    let(:hmac_signature) { OpenSSL::HMAC.hexdigest("SHA256", signing_key, json) }
    subject { described_class.(ward: ward, headers: headers, json: json) }

    context "the signatures match" do
      let(:headers) { {"AUTHORIZATION" => "HMAC-SHA256 #{hmac_signature}"} }
      let(:signing_key) { ward.secret }
      it { is_expected.to be true }
    end

    context "the signatures do not match" do
      let(:headers) { {"AUTHORIZATION" => "HMAC-SHA256 #{hmac_signature}"} }
      let(:signing_key) { "fake" }
      it { is_expected.to be false }
    end

    context "malformed headers" do
      let(:headers) { {} }
      let(:signing_key) { ward.secret }
      it { is_expected.to be false }
    end

  end
end

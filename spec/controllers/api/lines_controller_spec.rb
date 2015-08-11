require "spec_helper"

describe Api::LinesController do
  describe "GET#show" do
    before do
      RedisSourcer.source
    end

    it "returns the requested line" do
      get :show, id: 4

      expect(response.status).to eq 200
      expect(response.body).to eq "This is a test line 4"
    end

    it "throws an error if requested line is beyond source length" do
      get :show, id: 444

      expect(response.status).to eq 413
      expect(response.body).to eq "Line does not exist! Please select a lower number."
    end
  end
end

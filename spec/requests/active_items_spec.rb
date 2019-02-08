require 'rails_helper'

RSpec.describe "ActiveItems", type: :request do
  describe "GET /active_items" do
    it "works! (now write some real specs)" do
      get active_items_path
      expect(response).to have_http_status(200)
    end
  end
end

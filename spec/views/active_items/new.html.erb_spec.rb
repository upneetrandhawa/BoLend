require 'rails_helper'

RSpec.describe "active_items/new", type: :view do
  before(:each) do
    assign(:active_item, ActiveItem.new())
  end

  it "renders new active_item form" do
    render

    assert_select "form[action=?][method=?]", active_items_path, "post" do
    end
  end
end

require 'rails_helper'

RSpec.describe "active_items/edit", type: :view do
  before(:each) do
    @active_item = assign(:active_item, ActiveItem.create!())
  end

  it "renders the edit active_item form" do
    render

    assert_select "form[action=?][method=?]", active_item_path(@active_item), "post" do
    end
  end
end

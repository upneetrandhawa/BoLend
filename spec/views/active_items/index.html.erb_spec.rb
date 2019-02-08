require 'rails_helper'

RSpec.describe "active_items/index", type: :view do
  before(:each) do
    assign(:active_items, [
      ActiveItem.create!(),
      ActiveItem.create!()
    ])
  end

  it "renders a list of active_items" do
    render
  end
end

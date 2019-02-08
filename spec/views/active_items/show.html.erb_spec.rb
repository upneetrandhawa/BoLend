require 'rails_helper'

RSpec.describe "active_items/show", type: :view do
  before(:each) do
    @active_item = assign(:active_item, ActiveItem.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end

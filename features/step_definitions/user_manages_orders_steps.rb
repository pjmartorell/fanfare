# encoding: utf-8
When /^I create an order$/ do
  product = FactoryGirl.create :product
  FactoryGirl.create :product
  visit new_product_order_path
  select("1", :from => "product_order_order_products_attributes_0_quantity")
  fill_order_form
  click_button "Comprar"
end

When /^I visit shop$/ do
  product = FactoryGirl.create :hidden_product
  visit products_path
end

Then /^I should be in the final step$/ do
  page.should have_css('div.pay-button')
end

Then /^it should be hidden$/ do
  page.should_not have_content "T-Shirt"
end

def fill_order_form
  ["name", "last_name", "address", "town", "zip", "province", "phone"].each do |input|
    fill_in "product_order_shipping_#{input}", :with => input
  end

  select("Spain", :from => "product_order_shipping_country", :match => :first)
end

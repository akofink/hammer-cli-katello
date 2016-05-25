require_relative '../test_helper'
require_relative '../helpers/organization_helpers'
require_relative '../helpers/product_helpers'

describe "get product info" do
  include OrganizationHelpers
  include ProductHelpers

  it 'by ID' do
    expect_product_show(:id => 1)
    assert_equal(
      0,
      run_cmd(%w(product info --id 1)).exit_code
    )
  end

  it 'by organization id and product name' do
    expect_product_show(:name => 'product1', :org_id => 1, :id => 1)
    assert_equal(
      0,
      run_cmd(%w(product info --organization-id 1 --name product1)).exit_code
    )
  end

  it 'by organization name and product name' do
    expect_organization_search('org1', 1)
    expect_product_show(:name => 'product1', :org_id => 1, :id => 1)
    assert_equal(
      0,
      run_cmd(%w(product info --organization org1 --name product1)).exit_code
    )
  end
end

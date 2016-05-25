require_relative '../test_helper'
require_relative '../helpers/organization_helpers'
require_relative '../helpers/product_helpers'

describe 'delete a product' do
  include OrganizationHelpers
  include ProductHelpers

  it 'by ID' do
    api_expects(:products, :destroy, 'delete a product') do |par|
      par['id'] == 1
    end
    assert_equal(
      0,
      run_cmd(%w(product delete --id 1)).exit_code
    )
  end

  it 'by organization ID and product name' do
    expect_product_search(1, 'product1', 1)
    api_expects(:products, :destroy, 'delete a product') do |par|
      par['id'] == 1
    end
    assert_equal(
      0,
      run_cmd(%w(product delete --organization-id 1 --name product1)).exit_code
    )
  end

  it 'by organization name and product name' do
    expect_organization_search('org1', 1)
    expect_product_search(1, 'product1', 1)
    api_expects(:products, :destroy, 'delete a product') do |par|
      par['id'] == 1
    end
    assert_equal(
      0,
      run_cmd(%w(product delete --organization org1 --name product1)).exit_code
    )
  end
end

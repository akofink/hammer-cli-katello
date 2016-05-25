require_relative '../test_helper'
require_relative '../helpers/organization_helpers'
require_relative '../helpers/product_helpers'

describe 'update a product' do
  include OrganizationHelpers
  include ProductHelpers

  it 'by product ID' do
    api_expects(:products, :update, 'update a product') do |par|
      par['id'] == 1 &&
        par['description'] == 'new_description'
    end
    assert_equal(
      0,
      run_cmd(%w(product update --organization-id 1 --id 1 --description new_description)).exit_code
    )
  end

  it 'by organization ID and product name' do
    expect_product_search(1, 'product1', 1)
    api_expects(:products, :update, 'update a product') do |par|
      par['id'] == 1 &&
        par['description'] == 'new_description'
    end
    command = %w(product update --organization-id 1 --name product1 --description new_description)
    assert_equal(
      0,
      run_cmd(command).exit_code
    )
  end

  it 'by organization name and product name' do
    expect_organization_search('org1', 1)
    expect_product_search(1, 'product1', 1)
    api_expects(:products, :update, 'update a product') do |par|
      par['id'] == 1 &&
        par['description'] == 'new_description'
    end
    command = %w(product update --organization org1 --name product1 --description new_description)
    assert_equal(
      0,
      run_cmd(command).exit_code
    )
  end
end

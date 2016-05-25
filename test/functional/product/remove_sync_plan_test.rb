require_relative '../test_helper'
require_relative '../helpers/organization_helpers'
require_relative '../helpers/sync_plan_helpers'
require_relative '../helpers/product_helpers'

describe "remove a product's sync plan" do
  include OrganizationHelpers
  include SyncPlanHelpers
  include ProductHelpers

  it "by product ID" do
    api_expects(:products, :update, "set sync plan") do |params|
      params['id'] == 1 && params['sync_plan_id'].nil?
    end

    assert_equal(
      0,
      run_cmd(%w(product remove-sync-plan --id 1)).exit_code
    )
  end

  it "by product name" do
    expect_product_search(1, 'product1', 1)
    api_expects(:products, :update, "set sync plan") do |params|
      params['id'] == 1 && params['sync_plan_id'].nil?
    end

    assert_equal(
      0,
      run_cmd(%w(product remove-sync-plan
                 --organization-id 1
                 --name product1)).exit_code
    )
  end
end

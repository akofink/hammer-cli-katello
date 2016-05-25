require_relative '../test_helper'
require_relative '../helpers/organization_helpers'
require_relative '../helpers/sync_plan_helpers'
require_relative '../helpers/product_helpers'

describe "set a product's sync plan" do
  include OrganizationHelpers
  include SyncPlanHelpers
  include ProductHelpers

  it "by product ID and sync-plan ID" do
    api_expects(:products, :update, "set sync plan") do |params|
      params['id'] == 1 && params['sync_plan_id'] == 1
    end

    assert_equal(
      0,
      run_cmd(%w(product set-sync-plan --id 1 --sync-plan-id 1)).exit_code
    )
  end

  it "by product ID and sync-plan name (requires org ID)" do
    expect_sync_plan_search(1, 'syncplan1', 1)
    api_expects(:products, :update, "set sync plan") do |params|
      params['id'] == 1 && params['sync_plan_id'] == 1
    end

    assert_equal(
      0,
      run_cmd(%w(product set-sync-plan --organization-id 1 --id 1 --sync-plan syncplan1)).exit_code
    )
  end

  it "by product name and sync-plan name (both requiring org ID)" do
    expect_product_search(1, 'product1', 1)
    expect_sync_plan_search(1, 'syncplan1', 1)
    api_expects(:products, :update, "set sync plan") do |params|
      params['id'] == 1 && params['sync_plan_id'] == 1
    end

    assert_equal(
      0,
      run_cmd(%w(product set-sync-plan
                 --organization-id 1
                 --name product1
                 --sync-plan syncplan1)).exit_code
    )
  end
end

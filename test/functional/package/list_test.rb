require 'test_helper'
require 'functional/test_helper'
require 'functional/helpers/organization_helpers'
require 'functional/helpers/product_helpers'
require 'functional/helpers/repository_helpers'

describe 'listing packages' do
  include OrganizationHelpers
  include ProductHelpers
  include RepositoryHelpers

  before do
    @cmd = %w(package list)
  end

  let(:org_id) { 1 }
  let(:product_id) { 1 }
  let(:repo_id) { 1 }
  let(:empty_response) do
    {
      "total" => 0,
      "subtotal" => 0,
      "page" => "1",
      "per_page" => "1000",
      "error" => nil,
      "search" => nil,
      "sort" => {
        "by" => nil,
        "order" => nil
      },
      "results" => []
    }
  end

  it "lists packages for an organization" do
    params = ["--organization-id=#{org_id}"]

    ex = api_expects(:packages, :index, 'Packages list') do |par|
      par['organization_id'] == org_id &&
        par['page'] == 1 &&
        par['per_page'] == 1000
    end

    ex.returns(empty_response)
    expected_result = [
      '---|----------|-----------',
      'ID | FILENAME | SOURCE RPM',
      '---|----------|-----------',
      ''
    ]

    expected_result = success_result(expected_result.join("\n"))

    result = run_cmd(@cmd + params)
    assert_cmd(expected_result, result)
  end

  it "lists packages for a repository" do
    params = [
      "--organization=MyOrg",
      "--product=Fedora",
      "--repository='Fedora 23 x86_64'"
    ]

    expect_organization_search('MyOrg', 1)
    expect_product_search(org_id, 'Fedora', product_id)
    expect_repository_search(product_id, 'Fedora 23 x86_64', repo_id)

    ex = api_expects(:packages, :index, 'repository packages list') do |par|
      par['organization_id'] == org_id &&
        par['repository_id'] == repo_id &&
        par['page'] == 1 &&
        par['per_page'] == 1000
    end

    ex.returns(empty_response)
    expected_result = [
      '---|----------|-----------',
      'ID | FILENAME | SOURCE RPM',
      '---|----------|-----------',
      ''
    ]

    expected_result = success_result(expected_result.join("\n"))

    result = run_cmd(@cmd + params)
    assert_cmd(expected_result, result)
  end
end

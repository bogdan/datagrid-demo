require 'net/http'
require 'json'
require 'uri'

class IssuesGrid < BaseGrid
  FILTERS = %w(all assigned created repos)
  STATES = %w(all open closed)
  PER_PAGE = 10
  GITHUB_TOKEN = ENV['GITHUB_TOKEN']

  self.default_column_options = { order: false }

  scope { [] }

  attr_accessor :page

  dynamic do
    scope do
      IssuesGrid.fetch(api_attributes)
    end
  end

  def self.api_order(value)
    {
      # Disable default order behavior
      # because it is happening on the API side.
      order: -> { _1 },
      order_desc: -> { _1 },
      # Special configuration option that makes it convinient to asociate
      # API order value with column name that may not match.
      api_order: value,
    }
  end

  filter(
    :filter, :enum,
    select: FILTERS.map { [_1.humanize, _1] },
    default: 'all',
    dummy: true,
    include_blank: false,
  )
  filter(
    :state, :enum,
    select: STATES.map { [_1.humanize, _1] },
    default: 'all',
    dummy: true,
    include_blank: false,
  )
  filter(
    :since, :datetime,
    header: 'Updated Since',
    dummy: true,
    input_options: {type: 'date'},
  )

  column(:number) do |issue|
    format(issue[:number]) do |value|
      link_to "##{value}", issue[:html_url], class: 'link'
    end
  end

  column(:author) do |issue|
    user = issue[:user]
    format(user[:login]) do |value|
      link_to value, user[:html_url], class: 'link'
    end
  end

  column(:title) do |issue|
    issue[:title]
  end

  column(:state) do |issue|
    issue[:state].humanize
  end

  column(:comments, **api_order(:comments)) do |issue|
    issue[:comments]
  end

  column(:created_at, **api_order(:created)) do |issue|
    format(Time.parse(issue[:created_at])) do |value|
      time_ago_in_words(value) + " ago"
    end
  end

  column(:updated_at, **api_order(:updated)) do |issue|
    format(Time.parse(issue[:updated_at])) do |value|
      time_ago_in_words(value) + " ago"
    end
  end

  def self.fetch_github_issues(params)
    url = URI("https://api.github.com/repos/bogdan/datagrid/issues")

    params = params.compact

    url.query = URI.encode_www_form(params) unless params.empty?

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    # GitHub API requires a User-Agent header
    request['User-Agent'] = 'Ruby'
    if GITHUB_TOKEN
      request['Authorization'] = "Bearer #{GITHUB_TOKEN}"
    end

    response = http.request(request)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body).map(&:deep_symbolize_keys)
    elsif response.is_a?(Net::HTTPForbidden) && !GITHUB_TOKEN
      raise 'Github rate limit exceeded. Use GITHUB_TOKEN env variable to extend it.'
    else
      Rails.logger.error(response.inspect)
      Rails.logger.error(response.body)
      raise "Github API is down. #{response.inspect}"
    end
  end

  def self.fetch(params)
    paginate(fetch_github_issues(params), params[:page])
  end

  # Kaminari doesn't give a convinient way to display pagination
  # for already paginated collection with unknown total_count
  # We have to hack total_count to make it somewhat working
  def self.paginate(collection, page = 1)
    page = page&.to_i || 1
    Kaminari.paginate_array(
      collection,
      limit: PER_PAGE,
      offset: (page - 1) * PER_PAGE,
      total_count: PER_PAGE * (page + 1),
    )
  end

  def api_attributes
    attributes = attributes.clone

    {
      sort: api_sort,
      direction: api_direction,
      per_page: PER_PAGE,
      page: page,
      **filters.to_h { |filter| [filter.name, public_send(filter.name)] },
    }
  end

  def api_sort
    return nil unless order
    column_by_name(order).options[:api_order]
  end

  def api_direction
    return nil unless order
    descending ? "desc" : "asc"
  end

  # From GitHub API design, it is unknown at 100% if the current page is last or not.
  # We are only certian it is last when it has less assets than per_page would allow.
  # However, it doesn't guarantee that next page will not have 0 assets.
  def next_page?
    assets.size == PER_PAGE
  end
end

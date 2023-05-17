# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'json'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'simplecov'
SimpleCov.start do
  add_filter "spec/testable.rb"
end
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/6-0/rspec-rails
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

def test_data
  Market.destroy_all
  Vendor.destroy_all
  @market_1 = Market.create!(name: "Market 1", street: "One Street", city: "One City", county: "One County", state: "One State", zip: "11111", lat: "38.9169984", lon: "-77.0320505")
  @market_2 = Market.create!(name: "Market 2", street: "Two Street", city: "Two City", county: "Two County", state: "Two State", zip: "22222", lat: "38.9169984", lon: "-77.0320505")
  @market_3 = Market.create!(name: "Market 3", street: "Three Street", city: "Three City", county: "Three County", state: "Three State", zip: "33333", lat: "38.9169984", lon: "-77.0320505")
  @market_4 = Market.create!(name: "Market 4", street: "Four Street", city: "Four City", county: "Four County", state: "Four State", zip: "44444", lat: "38.9169984", lon: "-77.0320505")
  @market_5 = Market.create!(name: "Market 5", street: "Five Street", city: "Five City", county: "Five County", state: "Five State", zip: "55555", lat: "38.9169984", lon: "-77.0320505")

  @vendor_1 = Vendor.create!(name: "Vendor 1", description: "One Vendor", contact_name: "Contact One", contact_phone: "(111) 111-1111", credit_accepted: true)
  @vendor_2 = Vendor.create!(name: "Vendor 2", description: "Two Vendor", contact_name: "Contact Two", contact_phone: "(222) 222-2222", credit_accepted: false)
  @vendor_3 = Vendor.create!(name: "Vendor 3", description: "Three Vendor", contact_name: "Contact Three", contact_phone: "(333) 333-3333", credit_accepted: true)
  @vendor_4 = Vendor.create!(name: "Vendor 4", description: "Four Vendor", contact_name: "Contact Four", contact_phone: "(444) 444-4444", credit_accepted: false)
  @vendor_5 = Vendor.create!(name: "Vendor 5", description: "Five Vendor", contact_name: "Contact Five", contact_phone: "(555) 555-5555", credit_accepted: true)
  @vendor_6 = Vendor.create!(name: "Vendor 6", description: "Six Vendor", contact_name: "Contact Six", contact_phone: "(666) 666-6666", credit_accepted: false)
  @vendor_7 = Vendor.create!(name: "Vendor 7", description: "Seven Vendor", contact_name: "Contact Seven", contact_phone: "(777) 777-7777", credit_accepted: true)
  @vendor_8 = Vendor.create!(name: "Vendor 8", description: "Eight Vendor", contact_name: "Contact Eight", contact_phone: "(888) 888-8888", credit_accepted: false)
  @vendor_9 = Vendor.create!(name: "Vendor 9", description: "Nine Vendor", contact_name: "Contact Nine", contact_phone: "(999) 999-9999", credit_accepted: true)
  @vendor_10 = Vendor.create!(name: "Vendor 10", description: "Ten Vendor", contact_name: "Contact Ten", contact_phone: "(101) 010-1010", credit_accepted: false)

  @market_vendor_1 = MarketVendor.create!(vendor_id: @vendor_1.id, market_id: @market_1.id)
  @market_vendor_2 = MarketVendor.create!(vendor_id: @vendor_2.id, market_id: @market_1.id)
  @market_vendor_3 = MarketVendor.create!(vendor_id: @vendor_3.id, market_id: @market_2.id)
  @market_vendor_4 = MarketVendor.create!(vendor_id: @vendor_4.id, market_id: @market_2.id)
  @market_vendor_5 = MarketVendor.create!(vendor_id: @vendor_5.id, market_id: @market_3.id)
  @market_vendor_6 = MarketVendor.create!(vendor_id: @vendor_6.id, market_id: @market_3.id)
  @market_vendor_7 = MarketVendor.create!(vendor_id: @vendor_7.id, market_id: @market_4.id)
  @market_vendor_8 = MarketVendor.create!(vendor_id: @vendor_8.id, market_id: @market_4.id)
  @market_vendor_9 = MarketVendor.create!(vendor_id: @vendor_9.id, market_id: @market_5.id)
  @market_vendor_10 = MarketVendor.create!(vendor_id: @vendor_10.id, market_id: @market_5.id)
  @market_vendor_11 = MarketVendor.create!(vendor_id: @vendor_10.id, market_id: @market_1.id)
  @market_vendor_12 = MarketVendor.create!(vendor_id: @vendor_8.id, market_id: @market_2.id)
  @market_vendor_13 = MarketVendor.create!(vendor_id: @vendor_7.id, market_id: @market_3.id)
  @market_vendor_14 = MarketVendor.create!(vendor_id: @vendor_4.id, market_id: @market_4.id)
  @market_vendor_15 = MarketVendor.create!(vendor_id: @vendor_2.id, market_id: @market_5.id)
end
class TierApplier
  def initialize(customer)
    @customer = customer
  end

  def self.call(*args)
    new(*args)
  end

  def create_tire
    tier = Tier.find_by_name("Standard")
    @customer.customer_tiers.create(tier: tier)
  end

  def update_tier
    loyalty_point_in_current_year = @customer.acquired_loyalty_points(DateTime.now.year)
    customer_current_tier =  @customer.customer_tiers.last

    if loyalty_point_in_current_year.between?(1000, 4999)
      tier = Tier.find_by_name("Gold")
      customer_current_tier.update(tier: tier)
    elsif loyalty_point_in_current_year >= 5000
      tier = Tier.find_by_name("Platinum")
      customer_current_tier.update(tier: tier)
    end
  end
end
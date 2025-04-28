class TeaSubscriptionSerializer
  
  def self.format_subscription_list(subscriptions)
    {
      data: subscriptions.map do |sub|
        {
          id: sub.id.to_s,
          type: "tea_subscription",
          attributes: {
            customer_name: "#{sub.customer.first_name} #{sub.customer.last_name}",
            tea_type: "#{sub.tea.name}",
            frequency: sub.frequency,
            status: sub.status
          }
        }
      end,
      total_subscriptions: subscriptions.size
    }
  end
end
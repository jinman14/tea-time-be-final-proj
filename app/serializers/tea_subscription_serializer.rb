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

  def self.format_single_subscription(subscription)
    {
      data: {
        id: subscription.id.to_s,
        type: "tea_subscription",
        attributes: {
          frequency: subscription.frequency,
          status: subscription.status,
          customer_details: {
            full_name: "#{subscription.customer.first_name} #{subscription.customer.last_name}",
            email: subscription.customer.email,
            address: subscription.customer.address
          },
          tea_details: {
            name: subscription.tea.name,
            description: subscription.tea.description,
            brew_time: subscription.tea.brew_time,
            temperature: subscription.tea.temperature
          }
        }
      }
    }    
  end
end
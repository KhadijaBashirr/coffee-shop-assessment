# db/seeds.rb

# Create Categories
5.times do |i|
  Category.create!(
    name: "Category #{i + 1}",
    description: "Description for category #{i + 1}"
  )
end

# Create Customers
10.times do |i|
  Customer.create!(
    name: "Customer #{i + 1}",
    email: "customer#{i + 1}@example.com",
    phone_number: "123-456-789#{i}"
  )
end

# Create Tax Buckets
5.times do |i|
  TaxBucket.create!(
    tax_type: "Tax Type #{i + 1}",
    percentage: (i + 1) * 10
  )
end

# Create Items
items = []
40.times do |i|
  item = Item.create!(
    name: "Item #{i + 1}",
    description: "Description for item #{i + 1}",
    price: (i + 1) * 10.00,
    tax_bucket_id: TaxBucket.pluck(:id).sample,
    category_id: Category.pluck(:id).sample
  )
  items << item # Store created items in the items array
end

# Create Orders
10.times do |i|
  Order.create!(
    customer_id: Customer.pluck(:id).sample,
    status: [0, 1, 2].sample,
    total: (i + 1) * 50.00
  )
end

# Create Order Items
20.times do |i|
  OrderItem.create!(
    order_id: Order.pluck(:id).sample,
    item_id: Item.pluck(:id).sample,
    quantity: (i + 1),
    discount: (i + 1) * 2.0
  )
end

# Create Discount Deals
20.times do |i|
  discount_name = "Discount Deal #{i + 1}"
  item_ids = items.sample(2).map(&:id) # Sample 2 random item IDs
  discount_type = %w[fixed-price percentage fixed-discount].sample # Randomly choose a discount type
  discount_amount = case discount_type
                    when 'fixed-price'
                      (i + 1) * 5.0 # Example fixed price discount
                    when 'percentage'
                      (i + 1) * 5.0 # Example percentage discount
                    when 'fixed-discount'
                      (i + 1) * 2.0 # Example fixed discount amount
                    end

  DiscountDeal.create!(
    discount_name: discount_name,
    item_ids: item_ids, # Store as an integer array
    discount_type: discount_type,
    discount_amount: discount_amount
  )

  # Log the discount details to the terminal
  Rails.logger.debug do
    "Created #{discount_name} with items #{item_ids.join(', ')} and type #{discount_type}."
  end
end

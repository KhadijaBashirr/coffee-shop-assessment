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
    tax_percentage: (i + 1) * 0.5,
    tax: (i + 1) * 1.0
  )
end

# Create Items
40.times do |i|
  Item.create!(
    name: "Item #{i + 1}",
    description: "Description for item #{i + 1}",
    price: (i + 1) * 10.00,
    tax_bucket_id: TaxBucket.pluck(:id).sample,
    category_id: Category.pluck(:id).sample
  )
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

# Create Discounts
20.times do |i|
  Discount.create!(
    item_id: Item.pluck(:id).sample,
    required_item_id: Item.pluck(:id).sample,
    percentage: (i + 1) * 1.0
  )
end

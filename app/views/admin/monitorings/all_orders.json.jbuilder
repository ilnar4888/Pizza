json.array! @orders do |order|
  json.title "Order"
  json.start order[:created_at]
  json.url admin_order_path(id: order[:id])
end

Pay.setup do |config|
  # For use in the receipt/refund/renewal mailers
  config.business_name = "Sportify"
  config.business_address = "Calea Dorobantilor 113"
  config.application_name = "Sportify"
  config.support_email = "support@sportify.com"

  config.send_emails = true

  config.default_product_name = "default"
  config.default_plan_name = "default"

  config.automount_routes = true
  config.routes_path = "/pay" # Only when automount_routes is true
end

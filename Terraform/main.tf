# resource "azurerm_resource_group" "rg" {
#   name     = "flask-app-rg"
#   location = "West Europe"
# }

# resource "azurerm_service_plan" "app_service_plan" {
#   name                = "flask-app-plan"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   os_type             = "Linux"
#   sku_name            = "F1" # Free Tier (If not available, use B1)
#   depends_on = [ azurerm_resource_group.rg ]
# }

# resource "azurerm_linux_web_app" "web_app" {
#   name                = "flask-app-assignment-parth"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   service_plan_id     = azurerm_service_plan.app_service_plan.id

#   site_config {
#     application_stack {
#       python_version = "3.12"
#     }
#     always_on = false
#   }

#   app_settings = {
#     "WEBSITES_PORT" = "5000"
#   }

#   depends_on = [azurerm_service_plan.app_service_plan]
# }

# # resource "random_string" "suffix" {
# #   length  = 6
# #   special = false
# #   upper   = false
# # }

# output "app_url" {
#   value = "https://${azurerm_linux_web_app.web_app.default_hostname}"
# }

resource "azurerm_resource_group" "assignment_rg" {
  name = "python-app-rg"
  location = "canadacentral"
}

# resource "azurerm_app_service_plan" "asp" {
#   name                = "python-app-sp"
#   location            = "${azurerm_resource_group.rg.location}"
#   resource_group_name = "${azurerm_resource_group.rg.name}"
#   sku {
#     tier = "Standard"
#     size = "S1"
#   }
# }

resource "azurerm_service_plan" "assignment_app_service_plan" {
  name                = "python-app-sp"
  location            = "${azurerm_resource_group.assignment_rg.location}"
  resource_group_name = "${azurerm_resource_group.assignment_rg.name}"
  os_type             = "Linux"
  sku_name            = "S1"

  depends_on = [ azurerm_resource_group.assignment_rg ]
}

resource "azurerm_linux_web_app" "assignment_web_app" {
  name                = "python-app-web-app"
  location            = "${azurerm_resource_group.assignment_rg.location}"
  resource_group_name = "${azurerm_resource_group.assignment_rg.name}"
  service_plan_id     = azurerm_service_plan.assignment_app_service_plan.id

  site_config {
    application_stack {
      python_version = "3.10"
    }
  }

  app_settings = {
    "WEBSITES_PORT" = "5000"
  }

  depends_on = [ azurerm_resource_group.assignment_rg , azurerm_service_plan.assignment_app_service_plan ]
}
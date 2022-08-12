resource "azurerm_log_analytics_workspace" "log" {
  name = "network-log"
  location = var.rg_hub.location
  resource_group_name = var.rg_hub.name
  sku = "PerGB2018"
  retention_in_days = 30
}

resource "azurerm_monitor_action_group" "alerts" {
  name = "alerts"
  resource_group_name = var.rg_hub.name
  short_name = "someaction"

  email_receiver {
    name          = "sendtoadmin"
    email_address = "marit.lund@live.no"
  }
}
  resource "azurerm_monitor_activity_log_alert" "main" {
  name                = "example-activitylogalert"
  resource_group_name = var.rg_hub.name
  scopes              = [var.rg_hub.id]
  description         = "This alert will monitor log activity"

  criteria {
    category       = "Recommendation"
  }

  action {
    action_group_id = azurerm_monitor_action_group.alerts.id
  }
}

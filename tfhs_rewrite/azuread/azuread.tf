# Retrieve domain information
data "azuread_domains" "default" {
  only_initial = true
}

data "azurerm_subscription" "current" {
}


data "azuread_client_config" "current" {}

resource "azuread_group" "spoke1_group" {
  display_name     = "spoke1_group"
  security_enabled = true
}

resource "azuread_user" "spoke1_user" {
  user_principal_name = "example-group-member@${local.domain_name}"
  display_name        = "Spoke1 member"
  mail_nickname       = "example-group-member"
  password            = "SecretP@sswd99!"
}

resource "azuread_group_member" "some_member" {
  group_object_id  = azuread_group.spoke1_group.id
  member_object_id = azuread_user.spoke1_user.id
}

resource "azurerm_role_definition" "example" {
  name               = "my-custom-role-definition"
  scope              = data.azurerm_subscription.current.id

  permissions {
    actions     = ["Microsoft.Resources/subscriptions/resourceGroups/read"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.current.id, #insert group
  ]
}

resource "azurerm_role_assignment" "spoke1_member" {
  scope                = data.azurerm_subscription.current.id
  role_definition_id = azurerm_role_definition.example.id
  principal_id       = azuread_group.spoke1_group.id
}
resource "azurerm_policy_definition" "policies" {
  name = "locationPolicy"
  policy_type = "Custom"
  mode = "Indexed"
  display_name = "location policy definition"

  metadata = <<METADATA
    {
    "category": "General"
    }

METADATA


  policy_rule = <<POLICY_RULE
    {
    "if": {

                "allOf": [{

                "field": "type",

                "equals" : "Microsoft.Compute/virtualMachines"

            },

            {

                "not": {

                    "field": "location",

                    "in": "[parameters('allowedLocations')]"

                }

            }

            ]

            },

            "then": {

                "effect": "deny"

            }

        
   }
POLICY_RULE
#     {
#     "if": {
#       "not": {
#         "field": "location",
#         "in": "[parameters('allowedLocations')]"
#       }
#     },
#     "then": {
#       "effect": "deny"
#     }
#   }

  parameters = <<PARAMETERS
    {
    "allowedLocations": {
      "type": "Array",
      "metadata": {
        "description": "The list of allowed locations for resources.",
        "displayName": "Allowed locations",
        "strongType": "location"
      }
    }
  }
PARAMETERS

}

data "azurerm_subscription" "current" {}

resource "azurerm_subscription_policy_assignment" "location-policy" {
  name = "location-policy-assignment"
  subscription_id = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.policies.id
  description = "Policy Asssignment for allowed locations on subscription"
  display_name = "Allowed locations policy assignment"
  parameters = jsonencode({
    "allowedLocations":{
        "value": var.locations
    }
  })
}
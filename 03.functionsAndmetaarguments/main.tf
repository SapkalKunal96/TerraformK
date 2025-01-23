# locals {
#   storage_account_name = "kunalstorageaccount"
#   resource_group_name  = "kunalrg"
#   location             = "East US"
# }

################ Functions lower & replace ####################
locals {
  formatted_function = lower(replace(var.function, " ", "-"))
}

output "format_function" {
  value = local.formatted_function

}

################## merge function ####################

locals {
  tags = merge(var.default_tags, var.environment_tags)
}

output "merge_tags" {
  value = local.tags
}

################## substr function ####################
# Storage name does not accept more than 24 characters or special characters

locals {
  formated_substr_function = lower(replace(replace(substr(var.substr_function, 0, 23), "!", ""), " ", ""))
}

output "name_substr_function" {
  value = local.formated_substr_function

}

################## split & join function ####################

locals {
  formmated_ports = split(",", var.ports)
  nsg_rule = [for port in local.formmated_ports : {
    name        = "port-${port}"
    port        = port
    description = "Allowed Traffic On Port: ${port}"
    }
  ]
}

#We use the dynamic block to create multiple security rules based on the number of ports provided in the variable.

output "format_ports_name" {
  value = local.nsg_rule
}

output "formmated_ports" {
  value = local.formmated_ports

}


################## lookup function | mainly depends on variable ####################

locals {
  vm_size = lookup(var.vm_sizes, var.environment, "dev")
}

output "name_environment" {
  value = local.vm_size

}


####################### lenght & contains function ####################

#in variable only




###############################


resource "random_string" "random" {
  length           = 5
  special          = false
  override_special = "/@£$"
}


resource "azurerm_resource_group" "storage-rg" {
  name     = "${random_string.random.result}-rg"
  location = "East US"
}


resource "azurerm_network_security_group" "test-nsg" {
  name                = "test-nsg"
  location            = azurerm_resource_group.storage-rg.location
  resource_group_name = azurerm_resource_group.storage-rg.name
  dynamic "security_rule" {
    for_each = local.formmated_ports
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.key
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = security_rule.value.port == "80" ? "Tcp" : "http"
      source_port_range          = nsg_rule.value.port
      destination_port_range     = nsg_rule.value.port
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = security_rule.value.description
    }
  }
}





resource "azurerm_storage_account" "test-storage-account" {
  name                     = "${random_string.random.result}-kunal"
  resource_group_name      = azurerm_resource_group.storage-rg.name
  location                 = azurerm_resource_group.storage-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "example" {
  name                  = "content"
  storage_account_id    = azurerm_storage_account.test-storage-account.name
  container_access_type = "private"
}
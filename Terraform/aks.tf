resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.name}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.name}-dns"

  kubernetes_version = var.k8s_version

  
  network_profile {
  network_plugin = "azure"
  network_policy = "azure"
}

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_A2_v2"
    
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "test"
  }
}
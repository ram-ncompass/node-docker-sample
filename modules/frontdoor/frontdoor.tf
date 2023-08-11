resource "azurerm_frontdoor" "frontdoor" {
  name                = "ramFrontDoor"
  resource_group_name = azurerm_resource_group.rg.name

  routing_rule {
    name               = "frontdoorRoutingRule1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"] # url pattern to match for routing
    frontend_endpoints = ["ram-frontendEndpoint1"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "ramBackendBing"
    }
  }

  backend_pool_load_balancing {
    name = "ramLoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "ramHealthProbeSetting1"
  }

  backend_pool {
    name = "ramBackendBing"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "ramLoadBalancingSettings1"
    health_probe_name   = "ramHealthProbeSetting1"
  }

  frontend_endpoint {
    name      = "ram-frontendEndpoint1"
    host_name = "ram-frontend.azurefd.net"
  }
}
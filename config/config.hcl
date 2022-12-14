storage "raft" {
  path    = "./vault/data"
  node_id = "node1"
}

listener "tcp" {
  address     = "0.0.0.0:8080"
  tls_disable = "true"
}

api_addr = "http://0.0.0.0:8080"
cluster_addr = "https://0.0.0.0:8080"
ui = true


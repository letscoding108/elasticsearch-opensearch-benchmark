provider "google" {
  project = "es-benchmark-410706"           # project id, not the name
  region  = "us-west1"              	  # the region
  credentials = file("gcp-credentials.json")  # your service account credentials
}

resource "google_container_cluster" "my_cluster" {
  name           	= "my-benchmark-cluster"  # your cluster name
  location       	= "us-west1-a"

  remove_default_node_pool = true           	 
  initial_node_count   	= 1
}

resource "google_container_node_pool" "elasticsearch_nodes_32cpu" {
  name   	= "elasticsearch-nodepool-32"
  cluster	= google_container_cluster.my_cluster.id
  node_count = 3

  node_config {
	machine_type = "e2-standard-16"
	disk_size_gb = 50
  }
}

resource "google_container_node_pool" "opensearch_nodes_32cpu" {
  name   	= "opensearch-nodepool-32"
  cluster	= google_container_cluster.my_cluster.id
  node_count = 3

  node_config {
	machine_type = "e2-standard-16"
	disk_size_gb = 50
  }
}


resource "google_container_node_pool" "rally_nodes" {
  name   	= "rally-nodes"
  cluster	= google_container_cluster.my_cluster.id
  node_count = 3

  node_config {
	machine_type = "e2-standard-8"
	disk_size_gb = 40
  }
}

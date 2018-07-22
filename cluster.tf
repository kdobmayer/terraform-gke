resource "google_container_cluster" "primary" {
  name               = "gcek8s"
  initial_node_count = 3

  addons_config {
    kubernetes_dashboard {
      disabled = true
    }
  }

  logging_service    = "none"
  monitoring_service = "none"

  node_config {
    image_type   = "COS"
    machine_type = "n1-standard-1"
    disk_size_gb = 20

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    preemptible = true
  }

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.primary.name}"
  }

  provisioner "local-exec" {
    command = "kubectl create -f rbac-config.yaml && helm init --service-account tiller"
  }
}

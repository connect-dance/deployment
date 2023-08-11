# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {
  sensitive = true # Requires terraform >= 0.14
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
}

resource "hcloud_ssh_key" "marvin" {
  name       = "Marvin Admin Key"
  public_key = file("../keys/marvin_theia.pub")
}

# Create a server
resource "hcloud_server" "app_server" {
  name        = "app-server"
  image       = "ubuntu-22.04"
  server_type = "cax11"
  location    = "fsn1"
  ssh_keys    = [ hcloud_ssh_key.marvin ]
}

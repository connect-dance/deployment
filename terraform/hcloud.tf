resource "hcloud_ssh_key" "marvin" {
  name       = "Marvin Admin Key"
  public_key = file("../keys/marvin_theia.pub")
}

resource "hcloud_primary_ip" "main" {
  name          = "main"
  datacenter    = "fsn1-dc14"
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = true
}

# Create a server
resource "hcloud_server" "prod_fsn_01" {
  name        = "prod-fsn-01"
  image       = "ubuntu-22.04"
  server_type = "cax11"
  datacenter    = "fsn1-dc14"
  ssh_keys    = [ hcloud_ssh_key.marvin.name ]
  public_net {
    ipv4 = hcloud_primary_ip.main.id
  }
}

output "main_public_ip" {
  value = hcloud_primary_ip.main.ip_address
}

resource "hetznerdns_zone" "connect_dance" {
  name = "connect.dance"
  ttl = 3600
}

resource "hetznerdns_record" "prod_fsn_01" {
    zone_id = hetznerdns_zone.connect_dance.id
    name = "prod-fsn-01"
    value = hcloud_server.prod_fsn_01.ipv4_address
    type = "A"
    ttl= 60
}

resource "hetznerdns_record" "connect_dance" {
    zone_id = hetznerdns_zone.connect_dance.id
    name = "@"
    value = hcloud_server.prod_fsn_01.ipv4_address
    type = "A"
    ttl= 60
}

resource "hetznerdns_record" "catchall" {
    zone_id = hetznerdns_zone.connect_dance.id
    name = "*"
    value = "connect.dance."
    type = "CNAME"
    ttl= 60
}

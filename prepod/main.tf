module "rg" {
  source = "../modules/rg"
  rg     = var.rg
}

module "vnet" {

  depends_on = [module.rg]
  source     = "../modules/vnet"
  vnet       = var.vnet
}
module "subnet" {
  depends_on = [module.vnet]
  source     = "../modules/subnet"
  subnet     = var.subnet
}

module "publicip" {
  depends_on = [module.rg]
  source     = "../modules/public-ip"
  publicip   = var.publicip
}
module "vm" {
  depends_on      = [module.subnet, module.publicip]
  source          = "../modules/vm"
  virtual-machine = var.virtual-machine
  subnet_ids      = module.subnet.subnet_ids
  publicip_ids    = module.publicip.publicip_ids
}

module "postgress" {
  depends_on = [module.rg, module.subnet]
  source     = "../modules/postgress"
  postgres   = var.postgres
}
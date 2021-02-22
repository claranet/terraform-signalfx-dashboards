locals {
  aggregations = {
    last    = format(".mean(over='%dh')", var.is_parent ? 2 : 1),
    monthly = ".mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True)"
  }
  templates = {
    parent = "program_parent.tpl"
    child  = "program_child.tpl"
    common = "program_common.tpl"
  }
  publish = {
    HOSTS  = "False"
    MTS    = "False"
    MTSB   = "False"
    HOSTSB = "False"
    LIC    = "False"
    PRICE  = "False"
    MTSH   = "False"
    MTSBP  = "False"
    LICBP  = "False"
    AVGMTS = "False"
  }
  licence = {
    pool  = var.licence_pool
    price = var.licence_price
  }
}

# Create Security Groups
resource "aws_security_group" "sg" {
  for_each    = { for sg in var.aws_sg_configuration : sg.name => sg }
  name        = "${var.org_name}-${var.app_name}-${var.service_name}-${each.value.name}-${var.env}-sg"
  vpc_id      = var.aws_vpc_id
  description = "SG for ${each.value.name} in ${var.env}"

  tags = merge(var.default_tags, {
    Name    = "${var.org_name}-${var.app_name}-${var.service_name}-${each.value.name}-${var.env}-sg"
    Used_by = var.service_name
  })
}

# Flatten ingress rules
locals {
  ingress_rules = flatten([
    for sg in var.aws_sg_configuration : [
      for rule in sg.aws_sg_ingress_rules : [
        for cidr in rule.aws_sg_ingress_cidr_ipv4 : {
          sg_name       = sg.name
          port          = rule.aws_sg_inbound_port[0]
          protocol      = rule.aws_sg_protocal[0]
          cidr_ipv4     = rule.aws_sg_enable_cidr_ipv4 ? cidr : null
          ref_sg_name   = !rule.aws_sg_enable_cidr_ipv4 && length(rule.aws_reference_sg) > 0 ? rule.aws_reference_sg[0] : null
          ref_sg_id     = !rule.aws_sg_enable_cidr_ipv4 && length(rule.aws_reference_sg_id) > 0 ? rule.aws_reference_sg_id[0] : null
        }
      ]
    ]
  ])
}

# Create ingress rules
resource "aws_vpc_security_group_ingress_rule" "ingress" {
  for_each = {
    for r in local.ingress_rules :
    "${r.sg_name}-${r.cidr_ipv4 != null ? r.cidr_ipv4 : "no-cidr"}-${r.ref_sg_name != null ? r.ref_sg_name : "no-ref-sg"}-${r.port}" => r
  }
  security_group_id            = aws_security_group.sg[each.value.sg_name].id
  from_port                    = each.value.port
  to_port                      = each.value.port
  ip_protocol                  = each.value.protocol != "" ? each.value.protocol : "tcp"
  cidr_ipv4                    = each.value.cidr_ipv4
  referenced_security_group_id = each.value.ref_sg_name != null ? aws_security_group.sg[each.value.ref_sg_name].id : each.value.ref_sg_id
}

# Flatten egress rules
locals {
  egress_rules = flatten([
    for sg in var.aws_sg_configuration : [
      for rule in sg.aws_sg_egress_rules : [
        for cidr in rule.aws_sg_egress_cidr_ipv4 : {
          sg_name       = sg.name
          port          = rule.aws_sg_inbound_port[0]
          protocol      = rule.aws_sg_protocal[0]
          cidr_ipv4     = rule.aws_sg_enable_cidr_ipv4 ? cidr : null
          ref_sg_name   = !rule.aws_sg_enable_cidr_ipv4 && length(rule.aws_reference_sg) > 0 ? rule.aws_reference_sg[0] : null
          ref_sg_id     = !rule.aws_sg_enable_cidr_ipv4 && length(rule.aws_reference_sg_id) > 0 ? rule.aws_reference_sg_id[0] : null
        }
      ]
    ]
  ])
}

# Create egress rules
resource "aws_vpc_security_group_egress_rule" "egress" {
  for_each = {
    for r in local.egress_rules :
    "${r.sg_name}-${r.cidr_ipv4 != null ? r.cidr_ipv4 : "no-cidr"}-${r.ref_sg_name != null ? r.ref_sg_name : "no-ref-sg"}-${r.port}" => r
  }
  security_group_id            = aws_security_group.sg[each.value.sg_name].id
  from_port                    = each.value.port
  to_port                      = each.value.port
  ip_protocol                  = each.value.protocol != "" ? each.value.protocol : "tcp"
  cidr_ipv4                    = each.value.cidr_ipv4
  referenced_security_group_id = each.value.ref_sg_name != null ? aws_security_group.sg[each.value.ref_sg_name].id : each.value.ref_sg_id
}

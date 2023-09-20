module "organization_policies_type_boolean" {
  source   = "terraform-google-modules/org-policy/google"
  version  = "~> 5.2"
  for_each = local.boolean_type_organization_policies

  organization_id = var.organization_id
  policy_for      = local.policy_for
  policy_type     = "boolean"
  enforce         = "true"
  constraint      = "constraints/${each.value}"
}

module "public_access_prevention" {
  source  = "terraform-google-modules/org-policy/google"
  version = "~> 5.2"

  organization_id = var.organization_id
  policy_for      = local.policy_for
  policy_type     = "boolean"
  enforce         = "true"
  constraint      = "constraints/storage.publicAccessPrevention"

  # Can only be configurated after the public folder has been created
  exclude_folders = [google_folder.public.id]
}

/******************************************
  Compute org policies
*******************************************/
module "org_vm_external_ip_access" {
  source  = "terraform-google-modules/org-policy/google//modules/restrict_vm_external_ips"
  version = "~> 5.2"

  organization_id = var.organization_id
  policy_for      = local.policy_for
}

module "restrict_protocol_fowarding" {
  source  = "terraform-google-modules/org-policy/google"
  version = "~> 5.2"

  organization_id   = var.organization_id
  policy_for        = local.policy_for
  policy_type       = "list"
  allow             = ["INTERNAL"]
  allow_list_length = 1
  constraint        = "constraints/compute.restrictProtocolForwardingCreationForTypes"
}

/******************************************
  IAM
*******************************************/
module "org_domain_restricted_sharing" {
  source  = "terraform-google-modules/org-policy/google//modules/domain_restricted_sharing"
  version = "~> 5.2"

  organization_id  = var.organization_id
  policy_for       = local.policy_for
  domains_to_allow = [var.domain]
}

/******************************************
  Essential Contacts
*******************************************/
module "domain_restricted_contacts" {
  source  = "terraform-google-modules/org-policy/google"
  version = "~> 5.2"

  organization_id   = var.organization_id
  policy_for        = local.policy_for
  policy_type       = "list"
  allow_list_length = 1
  allow             = [local.domain_restricted_contact]
  constraint        = "constraints/essentialcontacts.allowedContactDomains"
}

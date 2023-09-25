locals {

  policy_for                = "organization"
  organization_folder_id    = "organizations/${var.org_id}"
  domain_restricted_contact = "@${var.domain}"

  boolean_type_organization_policies = toset([
    // Access management policies:
    "storage.uniformBucketLevelAccess",
    "compute.requireOsLogin",

    // IAM policies:
    "iam.automaticIamGrantsForDefaultServiceAccounts",
    "iam.disableServiceAccountKeyCreation",
    "iam.disableServiceAccountKeyUpload",

    // VM policies:
    "compute.disableNestedVirtualization",
    "compute.disableSerialPortAccess",
    "compute.disableGuestAttributesAccess",

    // Network policies:
    "compute.skipDefaultNetworkCreation",
    "compute.restrictXpnProjectLienRemoval",
    "compute.disableVpcExternalIpv6",
    "compute.setNewProjectDefaultToZonalDNSOnly",

    // SQL network policies:
    "sql.restrictPublicIp",
    "sql.restrictAuthorizedNetworks",
  ])
}

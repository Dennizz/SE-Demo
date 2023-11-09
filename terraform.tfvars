#Demo settings
company_name          = "7Eleven"
Prod_Smartgroup       = "Prod-Workloads"
Dev_Smartgroup        = "Dev-Workloads"
QA_Smartgroup         = "QA-Workloads"
Webgroup_1            = "Github"
Webgroup_1_SNI_Filter = "*.example.com"

#Build settings
high_availability = false

build_aws_transit   = true
build_aws_firenet   = true
build_azure_transit = true
build_azure_firenet = true
build_gcp_transit   = true
build_gcp_firenet   = true
build_oci_transit   = true
build_oci_firenet   = true

build_aws_spokes   = true
build_azure_spokes = true
build_gcp_spokes   = true
build_oci_spokes   = true

#Choose between "paloalto, "fortinet", "checkpoint". Be aware, fortinet isn't supported in OCI.
firewall_vendor = "paloalto"

#AWS Settings
AWS_account = "AWS"
AWS_region  = "us-east-1"

#Azure Settings
Azure_account = "Azure"
Azure_region  = "East US"

#Google settings
GCP_account = "GCP"
GCP_region  = "us-east1"
GCP_project = "xxx"

#OCI Settings
OCI_account = "OCI"
OCI_region  = "us-ashburn-1"
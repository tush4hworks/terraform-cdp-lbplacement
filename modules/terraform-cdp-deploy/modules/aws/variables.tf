# Copyright 2023 Cloudera, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ------- Global settings -------
# NOTE: Waiting on provider fix
# variable "tags" {
#   type        = map(any)
#   description = "Tags applied to provisioned resources"

# }

# ------- CDP Environment Deployment -------
variable "environment_name" {
  type        = string
  description = "Name of the CDP environment."

}

variable "datalake_name" {
  type        = string
  description = "Name of the CDP DataLake."

}

variable "cdp_xacccount_credential_name" {
  type        = string
  description = "Name of the CDP Cross Account Credential."

}

variable "cdp_admin_group_name" {
  type        = string
  description = "Name of the CDP IAM Admin Group associated with the environment."

}

variable "cdp_user_group_name" {
  type        = string
  description = "Name of the CDP IAM User Group associated with the environment."

}

# TODO: Will be re-introducted once provider supports other regions
# variable "cdp_control_plane_region" {
#   type        = string
#   description = "CDP Control Plane Region"

# }

variable "enable_ccm_tunnel" {
  type = bool

  description = "Flag to enable Cluster Connectivity Manager tunnel. If false then access from Cloud to CDP Control Plane CIDRs is required from via SG ingress"

}

variable "enable_raz" {
  type = bool

  description = "Flag to enable Ranger Authorization Service (RAZ)"

}

variable "multiaz" {
  type = bool

  description = "Flag to specify that the FreeIPA and DataLake instances will be deployed across multi-availability zones"

}

variable "freeipa_instances" {
  type = number

  description = "The number of FreeIPA instances to create in the environment"

}

variable "workload_analytics" {
  type = bool

  description = "Flag to specify if workload analytics should be enabled for the CDP environment"

}

variable "datalake_scale" {
  type = string

  description = "The scale of the datalake. Valid values are LIGHT_DUTY, MEDIUM_DUTY_HA."

  validation {
    condition     = contains(["LIGHT_DUTY", "MEDIUM_DUTY_HA"], var.datalake_scale)
    error_message = "Valid values for var: datalake_scale are (LIGHT_DUTY, MEDIUM_DUTY_HA)."
  }

}

variable "datalake_version" {
  type = string

  description = "The Datalake Runtime version. Valid values are semantic versions, e.g. 7.2.16"

  validation {
    condition     = length(regexall("\\d+\\.\\d+.\\d+", var.datalake_version)) > 0
    error_message = "Valid values for var: datalake_version must match semantic versioning conventions."
  }

}

# ------- Cloud Service Provider Settings -------
variable "region" {
  type        = string
  description = "Region which Cloud resources will be created"

}

variable "keypair_name" {
  type = string

  description = "SSH Keypair name in Cloud Service Provider. Required for CDP deployment on AWS."

  default = null
}

variable "vpc_id" {
  type        = string
  description = "AWS Virtual Private Network ID."

  validation {
    condition     = var.vpc_id != null
    error_message = "Valid values for var: vpc_id must be a existing AWS VPC."
  }

}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet ids."
}

# variable "private_subnet_ids" {
#   type        = list(string)
#   description = "List of private subnet ids."

# }

variable "subnets_for_cdp" {
  type        = list(string)
  description = "List of subnets to use for the CDP nodes. This is a subset of the public and private subnets and depending in the deployment template."

}

variable "security_group_default_id" {
  type = string

  description = "ID of the Default Security Group for CDP environment"
}

variable "security_group_knox_id" {
  type = string

  description = "ID of the Knox Security Group for CDP environment"
}

variable "endpoint_access_scheme" {
  type = string

  description = "The scheme for the workload endpoint gateway. PUBLIC creates an external endpoint that can be accessed over the Internet. PRIVATE which restricts the traffic to be internal to the VPC / Vnet. Relevant in Private Networks."

  validation {
    condition     = contains(["PUBLIC", "PRIVATE"], var.endpoint_access_scheme)
    error_message = "Valid values for var: endpoint_access_scheme are (PUBLIC, PRIVATE)."
  }
}

variable "data_storage_location" {
  type        = string
  description = "Data storage location."
}

variable "log_storage_location" {
  type        = string
  description = "Log storage location."
}

variable "backup_storage_location" {
  type        = string
  description = "Backup storage location."
}

variable "datalake_admin_role_arn" {
  type = string

  description = "Datalake Admin Role ARN."

  validation {
    condition     = var.datalake_admin_role_arn != null
    error_message = "Valid values for var: datalake_admin_role_arn must be a valid ARN for Datalake Admin Role."
  }

}

variable "ranger_audit_role_arn" {
  type = string

  description = "Ranger Audit Role ARN."

  validation {
    condition     = var.ranger_audit_role_arn != null
    error_message = "Valid values for var: ranger_audit_role_arn must be a valid ARN for Ranger Audit Role."
  }

}

variable "xaccount_role_arn" {
  type = string

  description = "Cross Account Role ARN."

  validation {
    condition     = var.xaccount_role_arn != null
    error_message = "Valid values for var: xaccount_role_arn must be a valid ARN for Cross Account Role."
  }

}

variable "log_instance_profile_arn" {
  type = string

  description = "Log Instance Profile ARN."

  validation {
    condition     = var.log_instance_profile_arn != null
    error_message = "Valid values for var: log_instance_profile_arn must be a valid ARN for Log Instance Profile."
  }

}

variable "idbroker_instance_profile_arn" {
  type = string

  description = "IDBroker Instance Profile ARN."

  validation {
    condition     = var.idbroker_instance_profile_arn != null
    error_message = "Valid values for var: idbroker_instance_profile_arn must be a valid ARN for IDBroker Instance Profile."
  }

}
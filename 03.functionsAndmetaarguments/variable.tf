variable "function" {
  description = "The name of the function"
  type        = string
  default     = "Project ALPHA Resource"

}

variable "default_tags" {
  type = map(string)
  default = {
    company    = "TechCorp"
    managed_by = "terraform"
  }
}

variable "environment_tags" {
  type = map(string)
  default = {
    environment = "production"
    cost_center = "cc-123"
  }
}

variable "substr_function" {
  type    = string
  default = "Welcome!! to Cloudenthusiastic channel"
}

variable "ports" {
  type    = string
  default = "80,443,8080,3306"
}






variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Invalid environment Must be dev, staging, prod"
  }
}



variable "vm_sizes" {
  type = map(string)
  default = {
    dev     = "standard_B1s",
    staging = "standard_E2s_v3",
    prod    = "standard_E64s_v3"
  }

}


################## lenght & contains function ####################

variable "standard_vm" {
  default = "standard_Bs1"
  type    = string
  validation {
    condition     = length(var.standard_vm) >= 7 && length(var.standard_vm) <= 20
    error_message = "The length of vm size incorrect."
  }
  validation {
    condition     = strcontains(var.standard_vm,"standard")
    error_message = "Standard Type Of VM not selected"
  }
}

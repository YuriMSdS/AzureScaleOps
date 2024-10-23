variable "admin_username" {
  description = "Admin username VM"
  type        = string
}

variable "admin_password" {
  description = "Admin PW VM"
  type        = string
  sensitive   = true
}

variable "computer_name" {
  description = "Computer name for the VM"
  type        = string
}
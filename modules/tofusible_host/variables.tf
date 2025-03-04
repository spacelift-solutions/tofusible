variable "groups" {
  type = list(string)
}

variable "extra_vars" {
  type    = map(any)
  default = null
}

variable "connection" {
  type    = string
  default = "ssh"
}

variable "host" {
  type = string
}

variable "port" {
  type    = number
  default = null
}

variable "user" {
  type    = string
  default = null
}

variable "password" {
  type      = string
  default   = null
  sensitive = true
}

variable "ssh_private_key_file" {
  type    = string
  default = null
}

variable "ssh_common_args" {
  type    = string
  default = null
}

variable "sftp_extra_args" {
  type    = string
  default = null
}

variable "scp_extra_args" {
  type    = string
  default = null
}

variable "ssh_extra_args" {
  type    = string
  default = null
}

variable "ssh_pipe" {
  type    = bool
  default = null
}

variable "ssh_executable" {
  type    = string
  default = null
}

variable "become" {
  type    = bool
  default = null
}

variable "become_method" {
  type    = string
  default = null
}

variable "become_user" {
  type    = string
  default = null
}

variable "become_password" {
  type      = string
  default   = null
  sensitive = true
}

variable "become_exe" {
  type    = string
  default = null
}

variable "become_flags" {
  type    = string
  default = null
}

variable "shell_type" {
  type    = string
  default = null
}

variable "python_interpreter" {
  type    = string
  default = null
}

variable "shell_executable" {
  type    = string
  default = null
}
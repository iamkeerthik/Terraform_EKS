variable "name" {
  description = "Tag Name to be assigned with resources"
  type        = string

}

variable "asg_desired_size" {
  type = number

}

variable "asg_max_size" {
  type = number

}

variable "asg_min_size" {
  type = number

}

variable "loki_desired_size" {
  type = number
}

variable "loki_max_size" {
  type = number
}

variable "loki_min_size" {
  type = number
}
# variable "launch_template_id" {
#   type = string
# }

# variable "launch_template_version" {
# }
variable "key_name" {
  type = string
}

variable "endpoint_private_access" {
  type = bool

}
variable "endpoint_public_access" {
  type = bool

}

variable "eks_version" {
}

variable "eks_instance_type" {
  type = string
}

variable "cluster_role_name" {
  type = string
}
variable "node_role_name" {
  type = string
}
variable "region" {
  type = string
}
variable "image_id" {
  type = string
}

variable "subnet1" {
  type = string
}
variable "subnet2" {
  type = string
}
variable "vpc" {
  type = string
}
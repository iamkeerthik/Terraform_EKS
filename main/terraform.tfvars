name                    = "my_cluster"
asg_desired_size        = 3
asg_max_size            = 5
asg_min_size            = 1
loki_desired_size       = 1
loki_max_size           = 1
loki_min_size           = 1
key_name                = "my_key"
endpoint_private_access = true
endpoint_public_access  = false
eks_version             = "1.24"
eks_instance_type       = "t3a.medium"
cluster_role_name       = "eks-cluster-role"
node_role_name          = "eks-nodegroup-role"
region                  = "ap-south-1"
image_id                = "ami-0bc134e8df5794848"
vpc                     = "my-vpc"
subnet1                 = "subnet1"
subnet2                 = "subnet2"


resource "aws_iam_role" "eks_role" {
  name = "devopsEksRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
  ]})

  tags = {
    Name = "devopsEksRole"
  }
}


# Attach AWS-managed policy to your role
resource "aws_iam_role_policy_attachment" "eks_cluster_attach" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}



resource "aws_iam_role" "node_role" {
  name = "devopsNodeGroupRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
})

  tags = {
    Name = "devopsNodeGroupRole"
  }
}



resource "aws_iam_role_policy_attachment" "node_policies_attach" {
  for_each = {
    "container_registry" = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    "cni_policy" = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    "worker_node_policy" = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  }
  role       = aws_iam_role.node_role.name
  policy_arn = each.value
} 


resource "aws_iam_role" "ec2_eks_role" {
  name = "devopsEc2EksRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
})

  tags = {
    Name = "devopsEc2EksRole"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_cluster_policies_attach" {
  role       = aws_iam_role.ec2_eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
} 


resource "aws_iam_role_policy_attachment" "ec2_service_policy_attach" {
  role       = aws_iam_role.ec2_eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}


resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_eks_role.name
}

resource "aws_iam_policy" "ec2_eks_custom_policy" {
  name        = "EC2EKSAccessPolicy"
  description = "Permissions for EC2 to authenticate with EKS"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "eks:DescribeCluster",
        "eks:ListClusters",
        "eks:ListAccessEntries",
        "eks:AccessKubernetesApi"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2_eks_custom_attach" {
  role       = aws_iam_role.ec2_eks_role.name
  policy_arn = aws_iam_policy.ec2_eks_custom_policy.arn
}


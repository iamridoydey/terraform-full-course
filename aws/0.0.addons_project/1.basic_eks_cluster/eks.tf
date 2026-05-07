resource "aws_eks_cluster" "devops_cluster" {
  name = "devops-cluster"

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.eks_role.arn
  version  = "1.35"

  vpc_config {
    subnet_ids = [
      aws_subnet.private-1a.id,
      aws_subnet.private-1b.id,
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_attach
  ]
}



resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.devops_cluster.name
  node_group_name = "devops-node-group"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = [aws_subnet.private-1a.id, aws_subnet.private-1b.id]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_policies_attach,
  ]
}


resource "aws_eks_access_entry" "cluster_admin_access" {
  cluster_name      = aws_eks_cluster.devops_cluster.name
  principal_arn     = aws_iam_role.ec2_eks_role.arn
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "cluster_admin_assoc" {
  cluster_name  = aws_eks_cluster.devops_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_iam_role.ec2_eks_role.arn

  access_scope {
    type = "cluster"
  }
}


# Create an access entry for your root user
resource "aws_eks_access_entry" "root_admin_access" {
  cluster_name  = aws_eks_cluster.devops_cluster.name
  principal_arn = "arn:aws:iam::836262100170:root"  
}

# Associate the AmazonEKSClusterAdminPolicy with the root user
resource "aws_eks_access_policy_association" "root_admin_assoc" {
  cluster_name  = aws_eks_cluster.devops_cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::836262100170:root"

  access_scope {
    type = "cluster"
  }
}

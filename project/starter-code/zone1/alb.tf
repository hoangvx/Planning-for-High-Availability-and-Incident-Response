module "project_alb" {
  source     = "./modules/alb"
  subnets_id = module.vpc.public_subnet_ids
  vpc_id     = module.vpc.vpc_id
  ec2        = module.project_ec2.aws_instance
}

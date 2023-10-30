  module "project_alb" {
   source             = "./modules/alb"
   name               = local.name
   account            = data.aws_caller_identity.current.account_id
   public_subnet_ids  = module.vpc.public_subnet_ids
   vpc_id             = module.vpc.vpc_id
   ec2                = module.project_ec2.aws_instance
 }
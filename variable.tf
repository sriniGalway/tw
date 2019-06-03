variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.
Example: ~/.ssh/terraform.pub
DESCRIPTION
}

variable "key_name" {
  description = "Desired name of AWS key pair"
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "eu-west-2"
}

# Ubuntu Xenial 16.04 LTS (x64)
variable "aws_amis" {
  default = {
    eu-west-1 = "ami-08660f1c6fb6b01e7"
    eu-west-2 = "ami-0f49c6ee8f381746f"
    us-west-1 = "ami-069339bea0125f50d"
    us-west-2 = "ami-08692d171e3cf02d6"
  }
  description = "I have added four regions: Ireland, London, California and Oregon. You can use as many regions as you want."
}

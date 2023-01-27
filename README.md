# EC2 instance with VPC by using Terraform for app in container with [Ansible provision](https://github.com/MykhailoPasiechnyk/ansible-docker-cron-job)

### Install Terraform:
- [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Set environment for Terraform:

#### for Windows:
```
$ set AWS_ACCESS_KEY_ID="access_key"
$ set AWS_SECRET_ACCESS_KEY="secret_key"
```

#### for Linux:
```
$ export AWS_ACCESS_KEY_ID="access_key"
$ export AWS_SECRET_ACCESS_KEY="secret_key"
```

### Git Clone:
```
$ git clone https://github.com/MykhailoPasiechnyk/terraform-EC2-instance-with-VPC.git
```

### Run all resources in AWS:
```
$ terraform apply
```

### Clean up all resources
```
$ terraform destroy
```

# terraform-aws
Terraform scripts for AWS cloud

Provide Terraform with AWS keys
```bash
export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=YYYYYYYYYYYYYYYYYYY
```

All operations has to be done inside `clickhouse` folder
```bash
cd clickhouse
```

Now we need to init Terraform's repo
```bash
cd clickhouse
../bin/terraform init
```

Now we are ready to start Terraforming.

Setup variables, located in `var.tf` file, such as:
  * `vpc_id`
  * `subnet_id`
  * `instance_type`
  * `root_block_device_volume_size`
  * `key_name`
  * `ch_node_multiple_count`

```bash
vim var.tf
```

Take a look on what Terraform is going to do - review plan of the migration
```bash
../bin/terraform plan
```

In case all looks good - do Terraforming

```bash
../bin/terraform apply
```
It may take some time.

When you are done - destroy all created AWS resources with
```bash
../bin/terraform destroy
```


# terraform-aws
Terraform scripts for AWS cloud


All operations has to be done insode `clickhouse` folder
```bash
cd clickhouse
```

Now we need to init Terraform's repo
```bash
cd clickhouse
../bin/terraform init
```

Now we are ready to start Terraforming
Setup veriables such as:
  * vpc_id
  * subnet_id
  * instance_type
  * root_block_device_volume_size
  * key_name
  * ch_node_multiple_count

```bash
vim var.tf
```

Take a look on what Terraform is going to do - review plan of the migration
```bash
../bin/terrafrom plan
```

In case all looks good - do Terraforming

```bash
../bin/terraform apply
```


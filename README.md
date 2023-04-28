# Registry infrastructure

> This folder contains infrastructure for registry. Start by provisioning infrastructure, then run the script after provision in instance to up the registry

# Prerequisite
- Terraform CLI installation on local machine
- AWS Token: include `ACCESS KEY`, `SECRET KEY` & `TOKEN` (If exists)
- A forked [registry service repoistory](https://github.com/thinhlh/registry-service)

# Provision infrastructure

## With forked repo
    1. Clone the repo
    2. Replace all `registry.thinhlh.com` to `registry.yourdomain.com`
    3. Commit & push new version

## With this repo

1. Create and fill the .tfvars file

    ```
    aws_access_key = 
    aws_secret_key = 
    aws_region = 

    key_pair_name = 
    ```

2. Run Terraform plan to preview infrastructure
    
    ```
    terraform init
    terraform plan --var-file ./.tfvars
    ```

3. Run Terraform apply to start provisioning infrastructure

    ```
    terraform apply --var-file ./.tfvars
    ```

4. Copy instance public ip at output and set DNS record point to IP

5. Replace fields in [post-provisioning-script](./scripts/post-provisioning.sh)
    - DNS domain name
    - Email
    - Path to key file
    - Public IP Address you received from infra
    
    ```
    EMAIL=example@gmail.com
    DOMAIN=registry.example.com
    public_ip=1.1.1.1
    key.pem=/path/to/your/key
    ```

6. Run shell script
    ```
    ./scripts/post-provisioning.sh
    ```
# How to healthcheck? Go to domain below
```
https://registry.example.com/v2/_catalog
```
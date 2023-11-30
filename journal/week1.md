# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

The `-var-file` flag is used to pass Input Variable values into Terraform plan and apply commands using a file that contains the values. This allows us to save the Input Variable values in a file with a `.tfvars` extension that can be checked into source control for our variable environments we need to deploy,

The `.tfvars` file contents will contain the definition for the Input Variable values to pass into the Terraform commands. These are defined in a similar way to how local Variables are defined in Terraform code.

Here’s an example `.tfvars` file defining a few Input Variable values:

```
environment = 'production'
location    = 'eastus'

vm_instance_count = 4
vm_ip_allow_list  = [
  '10.50.0.1/32'
  '10.83.0.5/32'
]
```

Once we have one or more `.tfvars` files created, we can then use the `-var-file` flag to pass in the name of the file for Terraform to pull in for passing Input Variables to the Terraform command. Multiple `-var-file` flags can be used on the same Terraform command to pass in multiple `.tfplans` files as necessary.

Here’s a couple examples of using the `-var-file` flag to pass in `.tfvars` files to Terraform commands:

```sh
# Pass .tfvar files to 'plan' command
terraform plan \
-var-file 'production.tfvars' \
-var-file 'secrets.tfvars'

# Pass .tfvar files to 'apply ' command
terraform apply \
-var-file 'production.tfvars' \
-var-file 'secrets.tfvars'
```

### terraform.tvfars

This is the default file to load in terraform variables in bulk

### auto.tfvars

An alternative to using the "-var-file" flag is to use a file name with the ".auto.tfvars" extension. This will be loaded automatically, similar to the "terraform.tfvars" file.

### order of terraform variables

Terraform uses a specific order of precedence when determining the value of a variable. If the same variable is assigned multiple values, Terraform will use the value of highest precedence, overriding any other values. Below is the precedence order starting from the highest priority to the lowest.

1. Environment variables `TF_VAR_variable_name`
2. The `terraform.tfvars` file
3. The `terraform.tfvars.json` file
4. Any `.auto.tfvars` or `.auto.tfvars.json` files, processed in lexical order of their filenames.
5. Any `-var` and `-var-file` options on the command line, in the order they are provided.
6. Variable defaults

## Dealing With Configuration Drift

## What happens if we lose our state file?

If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps. 

If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift
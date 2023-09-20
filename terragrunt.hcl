remote_state {
    backend = "gcs"
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite"
    }
    config = {
        # project="<your-project-id>" terragrunt init / project="<your-project-id>" terragrunt plan
        project        = get_env("project")
        location       = "us"
        bucket         = "tf-state-bootstrap-0002"
        prefix         = "${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}"
        # prefix         = "${path_relative_to_include()}/terraform.tfstate"

        enable_bucket_policy_only = true
    }
}

terraform {
  extra_arguments "root_vars" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-var-file=./terraform.tfvars"
    ]
  }
}

.PHONY: aws
ifeq (aws,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif
aws: ## AWS CLI commands with arguments.
	docker-compose run --rm awscli $(RUN_ARGS)

.PHONY: format
format: ## Terraform fmt command.
	docker-compose run --rm terraform fmt

.PHONY: plan
plan: ## Terraform plan command.
	docker-compose run --rm terraform plan

.PHONY: apply
apply: ## Terraform apply command.
	docker-compose run --rm terraform apply

.PHONY: destroy
destroy: ## Terraform destroy command.
	docker-compose run --rm terraform destroy

.PHONY: ssh
ssh: ## SSH connect to web server. 
	$(eval PUBLIC_IP := $(shell docker-compose run --rm terraform output public_ip))
	ssh -i laravel-blog-sample-key.id_rsa ec2-user@$(PUBLIC_IP)
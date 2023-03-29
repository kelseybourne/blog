.PHONY : help
help: # Display help
	@echo "Usage: make [target]"
	@echo "targets:"
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST)

.PHONY : up
up: ## spin up docker containers
	@docker-compose up -d
  
PHONY : down
down: ## spin down docker containers
	@docker-compose down

PHONY : clean
clean: down ## clean everything
	@rm -rf _site
	@docker rmi -f blog-jekyll

PHONY : restart
restart: clean up ## restart
	@echo "restarting" && docker logs -f blog

PHONY : list
list: ## list wsl stuff
	@wsl --list --verbose


PHONY : logs
logs: ## attach to logs for container
	@docker logs -f blog
  
PHONY : ubuntu
ubuntu: ## start ubuntu wsl prompt
	@wsl --distribution Ubuntu
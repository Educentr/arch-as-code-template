
IMAGE_NAME = structurizr/lite
CONTAINER_NAME = structurizr-lite-container
PORT = 8080

ifndef BRANCH_NAME
BRANCH_NAME = $(shell git branch --show-current)
endif

.PHONY: run
run:
	docker pull $(IMAGE_NAME) ; \
	docker run -it --rm -p $(PORT):8080 -e "BRANCH_NAME=$(BRANCH_NAME)" -v $(CURDIR):/usr/local/structurizr $(IMAGE_NAME)

.PHONY: proj
proj:
	./template/proj.sh $(ARGS)

.PHONY: ss_group
ss_group:
	./template/ss_group.sh $(ARGS)

.PHONY: init
init:
	./template/init.sh $(ARGS)

.PHONY: json
json:
	BRANCH_NAME=$(BRANCH_NAME) ~/structurizr_cli/structurizr.sh export -w workspace.dsl -f json -o /private/tmp/$(BRANCH_NAME).json
	jq '.version="$(BRANCH_NAME)"' /private/tmp/$(BRANCH_NAME).json/workspace.json > /private/tmp/$(BRANCH_NAME).json/workspace_upload.json

.PHONY: push
push:
	~/structurizr_cli/structurizr.sh push -url https://structurizr.flora.ltfs.tools/api -id 1 -key $(STRUCTURIZR_KEY) -secret $(STRUCTURIZR_SECRET) -w /private/tmp/$(BRANCH_NAME).json/workspace_upload.json


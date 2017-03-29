.PHONY: init up down shell install

PORT ?= 80

init:
	chmod +x init.sh && ./init.sh $(PORT)
up:
	docker-compose up -d
down:
	docker-compose down
shell:
	docker exec -it $(notdir $(CURDIR))_tao_1 bash
install:
	docker exec -it $(notdir $(CURDIR))_tao_1 bash install.sh $(PORT)
update:
	docker exec -it $(notdir $(CURDIR))_tao_1 php tao/scripts/taoUpdate.php
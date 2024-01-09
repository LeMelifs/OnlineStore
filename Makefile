ifeq ($(OS),Windows_NT)
	SLEEP := timeout
else
	SLEEP := sleep
endif

file = ./serv_pass.txt

pass := $(shell cat ${file})

# dev

start-dev:
	docker compose -f docker-compose-dev.yaml up --build -d
	$(SLEEP) 2

	docker compose -f docker-compose-dev.yaml exec -w /api api python -m alembic upgrade head

update-dev:
	docker compose -f docker-compose-dev.yaml cp ./backend/api api:.
	docker compose -f docker-compose-dev.yaml exec -w /api api python -m alembic upgrade head

	docker compose -f docker-compose-dev.yaml cp ./frontend frontend:/opt/frontend
	docker compose -f docker-compose-dev.yaml restart web

update-api-dev:
	docker compose -f docker-compose-dev.yaml cp ./backend/api api:.

update-web-dev:
	docker compose -f docker-compose-dev.yaml cp ./frontend web:/opt
	docker compose -f docker-compose-dev.yaml restart web

update-db-dev:
	docker compose -f docker-compose-dev.yaml exec -w /api api python -m alembic upgrade head

new-migr:
	docker compose -f docker-compose-dev.yaml cp ./backend/api/database api:/api
	docker compose -f docker-compose-dev.yaml exec -w /api api python -m alembic revision --autogenerate -m "$(name)"
	docker compose -f docker-compose-dev.yaml exec -w /api api python -m alembic upgrade head
	docker compose -f docker-compose-dev.yaml cp api:/api/migrations/versions ./backend/api/migrations

# prod

start-prod:
	docker compose -f docker-compose-prod.yaml up --build -d
	docker compose -f docker-compose-prod.yaml exec -w /api api python -m alembic upgrade head

update-prod:
	docker compose -f docker-compose-prod.yaml cp ./frontend web:/opt
	docker compose -f docker-compose-prod.yaml exec -w /opt/frontend web yarn quasar clean
	docker compose -f docker-compose-prod.yaml exec -w /opt/frontend web yarn build
	docker compose -f docker-compose-prod.yaml restart web
	docker compose -f docker-compose-prod.yaml cp api:api/src/static/img ./backend/api/src/static
	docker compose -f docker-compose-prod.yaml exec database sh -c 'pg_dump -h 127.0.0.1 --username=postgres -d postgres > dumps/$$(date +'%Y-%m-%d_%H-%M-%S').dump'
	sshpass -p "$(pass)" scp -r /home/poslam/onlinestore/backend/dumps poslam@188.127.225.179:/home/poslam/onlinestore_dumps
	sshpass -p "$(pass)" scp -r /home/poslam/onlinestore/backend/api/src/static/img poslam@188.127.225.179:/home/poslam/onlinestore_imgs
	docker compose -f docker-compose-prod.yaml cp ./backend/api api:.
	docker compose -f docker-compose-prod.yaml restart api
	docker compose -f docker-compose-prod.yaml exec -w /api api python -m alembic upgrade head

update-prod-full:
	docker compose -f docker-compose-prod.yaml cp api:api/src/static/img ./backend/api/src/static
	docker compose -f docker-compose-prod.yaml exec database sh -c 'pg_dump -h 127.0.0.1 --username=postgres -d postgres > dumps/$$(date +'%Y-%m-%d_%H-%M-%S').dump'
	sshpass -p "$(pass)" scp -r /home/poslam/onlinestore/backend/dumps poslam@188.127.225.179:/home/poslam/onlinestore_dumps
	sshpass -p "$(pass)" scp -r /home/poslam/onlinestore/backend/api/src/static/img poslam@188.127.225.179:/home/poslam/onlinestore_imgs
	docker compose -f docker-compose-prod.yaml up --build -d
	docker compose -f docker-compose-prod.yaml exec -w /api api python -m alembic upgrade head
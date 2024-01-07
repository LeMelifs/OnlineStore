ifeq ($(OS),Windows_NT)
	SLEEP := timeout
else
	SLEEP := sleep
endif


# dev

start-dev:
	docker compose -f docker-compose-dev.yaml up --build -d
	$(SLEEP) 2

	docker compose -f docker-compose-dev.yaml exec -w /api api python -m alembic upgrade head

update-dev:
	docker compose -f docker-compose-dev.yaml cp ./backend-fastapi/api api:.
	docker compose -f docker-compose-dev.yaml exec -w /api api python -m alembic upgrade head

	docker compose -f docker-compose-dev.yaml cp ./frontend frontend:/opt/app
	docker compose -f docker-compose-dev.yaml restart web

update-api-dev:
	docker compose -f docker-compose-dev.yaml cp ./backend-fastapi/api api:.

update-web-dev:
	docker compose -f docker-compose-dev.yaml cp ./frontend/src web:/opt/app
	docker compose -f docker-compose-dev.yaml restart web

update-db-dev:
	docker compose -f docker-compose-dev.yaml exec -w /api api python -m alembic upgrade head

new-migr:
	docker compose -f docker-compose-dev.yaml cp ./backend-fastapi/api/database api:/api
	docker compose -f docker-compose-dev.yaml exec -w /api api python -m alembic revision --autogenerate -m "$(name)"
	docker compose -f docker-compose-dev.yaml exec -w /api api python -m alembic upgrade head
	docker compose -f docker-compose-dev.yaml cp api:/api/migrations/versions ./backend-fastapi/api/migrations

# prod

start-prod:
	docker compose -f docker-compose-prod.yaml up --build -d
	docker compose -f docker-compose-prod.yaml exec -w /opt/app web yarn build
	docker compose -f docker-compose-prod.yaml cp web:/opt/app/dist ./frontend
	docker compose -f docker-compose-prod.yaml exec -w /api api python -m alembic upgrade head
	docker compose -f docker-compose-prod.yaml stop web

update-prod:
	docker compose -f docker-compose-prod.yaml build web
	docker compose -f docker-compose-prod.yaml exec -w /opt/app web yarn build
	docker compose -f docker-compose-prod.yaml exec database sh -c 'pg_dump -h 127.0.0.1 --username=postgres -d postgres > dumps/$$(date +'%Y-%m-%d_%H-%M-%S').dump'
	docker compose -f docker-compose-prod.yaml cp ./backend-fastapi/api api:.
	docker compose -f docker-compose-prod.yaml cp web:/opt/app/dist ./frontend
	docker compose -f docker-compose-prod.yaml restart api
	docker compose -f docker-compose-prod.yaml exec -w /api api python -m alembic upgrade head
	docker compose -f docker-compose-prod.yaml stop web

update-prod-full:
	docker compose -f docker-compose-prod.yaml exec database sh -c 'pg_dump -h 127.0.0.1 --username=postgres -d postgres > dumps/$$(date +'%Y-%m-%d_%H-%M-%S').dump'
	docker compose -f docker-compose-prod.yaml up --build -d
	docker compose -f docker-compose-prod.yaml exec -w /api api python -m alembic upgrade head
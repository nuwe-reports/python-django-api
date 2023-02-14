build:
	docker-compose build

down:
	docker-compose down

up: build migrate
	docker-compose up -d

migrate:
	docker-compose run --rm api python manage.py migrate

deps:
	docker-compose run --rm api poetry install

bash:
	docker-compose run --rm api /bin/sh

test: build migrate
	docker-compose run --rm api python manage.py test -r json > coverage.json

coverage: build migrate
	docker-compose run --rm api coverage run --source='api' --omit='api/tests/*' manage.py test --verbosity=2
	docker-compose run --rm api coverage json > coverage.json
	mv coverage.json api/coverage.json

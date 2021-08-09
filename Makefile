usage:
	@echo 'make [check|build|run|push]'

check:
	safety check
	# bandit -r monitor/
	pylint --django-settings-module=monitor.settings monitor/*
	python monitor/manage.py check

build: check
	pipenv lock -r > requirements.txt
	docker build -t monitor:latest .

run: build
	docker run --rm -d -p 8000:8000 --name monitor monitor:latest

push: build
	git push

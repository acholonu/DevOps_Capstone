## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# installs hadolint
	wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 &&\
            chmod +x /bin/hadolint

	# installs poetry
	curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
	#poetry init --name Capstone --author "Ugochi Jones <ucacholonu@hotmail.com>" \
	# --description "Udacity Capstone Project for DevOps Nano Degree" --python [^3.10]

activate-environment:
	# Create python virtualenv & package dependency files
	python3 --version
	poetry --version
	poetry shell # activate virtualenvironment

install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip
	poetry self update
	poetry --version
	cat requirements.txt|xargs poetry add

upgrade:
	poetry upgrade

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

validate-circleci:
	# Validate circleci config.yml file
    # See https://circleci.com/docs/2.0/local-cli/#processing-a-config
    circleci config process .circleci/config.yml

run-circleci-local:
	# run circleci on local machine
    # See https://circleci.com/docs/2.0/local-cli/#running-a-job
    circleci local execute

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles.  I am ignoring rules DL3013 & DL3042
	hadolint --ignore DL3013 --ignore DL3042 Dockerfile

	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203,W1309 app.py

all: activate_environment install lint test

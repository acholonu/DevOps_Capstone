## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# installs hadolint
	sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64
	sudo chmod +x /bin/hadolint

	# installs poetry
	#sudo curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
	poetry self update # update poetry
	poetry --version

create-environment:
	# Create python virtualenv & package dependency files
	python3 --version
	poetry --version
	python -m venv capstone # I named virtual environment capstone
	. capstone/bin/activate
	poetry env info
	
poetry-install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip
	poetry self update
	poetry --version
	cat requirements.txt|xargs poetry add
	poetry show

pip-install:
	pip install --upgrade pip
	pip install -r requirements.txt

upgrade:
	poetry upgrade

test:
	# Additional, optional, tests could go here
	#python -m pytest --nbval notebook.ipynb # Testing notebooks

	# Run all tests in the test_ops folder
	# The --cov tells pytest what code should it review (what is the src codebase)
	python -m pytest -vv --cov=dagster dagster/dagster_capstone_tests/test_ops

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles.  I am ignoring rules DL3013 & DL3042
	hadolint --ignore DL3013 --ignore DL3042 dagster/Dockerfile

	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203,W1309,E1120 dagster/dagster_capstone/hello_world.py
	black dagster/dagster_capstone/hello_world.py
	
validate-circleci:
	# Validate circleci config.yml file
	circleci config process .circleci/config.yml

run-circleci-local:
	# run circleci on local machine
	circleci local execute

all: create_environment poetry-install lint test

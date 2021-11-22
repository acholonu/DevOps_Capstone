
# install dependency management
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -

# install pyenv & virtualenvs

# How to run the docker files
docker build -f Dagster.Dockerfile .
docker build -f DB.Dockerfile .
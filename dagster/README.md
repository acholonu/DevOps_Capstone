# dagster_capstone

Welcome to your new Dagster repository.

## Contents

| Name                     | Description                                                                       |
| ------------------------ | --------------------------------------------------------------------------------- |
| `README.md`              | A description and guide for this code repository                                  |
| `setup.py`               | A build script with Python package dependencies for this code repository          |
| `workspace.yaml`         | A file that specifies the location of the user code for Dagit and the Dagster CLI |
| `dagster_capstone/`       | A Python directory that contains code for your Dagster repository                 |
| `dagster_capstone_tests/` | A Python directory that contains tests for `dagster_capstone`                      |

## Getting up and running

1. Create a new Python environment and activate.

### Pyenv

```bash
export PYTHON_VERSION=X.Y.Z
pyenv install $PYTHON_VERSION
pyenv virtualenv $PYTHON_VERSION dagster_capstone
pyenv activate dagster_capstone
```

### Conda

```bash
export PYTHON_VERSION=X.Y.Z
conda create --name dagster_capstone python=PYTHON_VERSION
conda activate dagster_capstone
```

2. Once you have activated your Python environment, install your repository as a Python package. By
using the `--editable` flag, `pip` will install your repository in
["editable mode"](https://pip.pypa.io/en/latest/reference/pip_install/?highlight=editable#editable-installs)
so that as you develop, local code changes will automatically apply.

```bash
pip install --editable .
```

## Local Development

1. Set the `DAGSTER_HOME` environment variable. Dagster will store run history in this directory.

```base
mkdir ~/dagster_home
export DAGSTER_HOME=~/dagster_home
```

2. Start the [Dagit process](https://docs.dagster.io/overview/dagit). This will start a Dagit web
server that, by default, is served on <http://localhost:3000>.

```bash
dagit
```

3. (Optional) If you want to enable Dagster

[Schedules](https://docs.dagster.io/overview/schedules-sensors/schedules) or
[Sensors](https://docs.dagster.io/overview/schedules-sensors/sensors) for your jobs, start the
[Dagster Daemon process](https://docs.dagster.io/overview/daemon#main) **in a different shell or terminal**:

```bash
dagster-daemon run
```

## Local Testing

Tests can be found in `dagster_capstone_tests` and are run with the following command:

```bash
pytest dagster_capstone_tests
```

As you create Dagster ops and graphs, add tests in `dagster_capstone_tests/` to check that your
code behaves as desired and does not break over time.

[For hints on how to write tests for ops and graphs in Dagster,
[see our documentation tutorial on Testing](https://docs.dagster.io/tutorial/testable).

## Notes

- Dagster automatically creates a dagster.html in the home folder (`~/dagster_home`)
- Differences between **docker compose** and **Dockerfile**, many of the commands overlap.  But you want to do anything related to file system, adding files/directory, adding software, packages in the **Dockerfile**. All the building and running of containers, and connecting containers should occur in the **docker-compose** file.
  - To run docker compose file to create your stacke: `docker compose up -d` (options says to run in the background).  To delete stack: `docker compose down -d`.  The goal of docker compose is: *is a tool for defining and running multi-container Docker applications*. So If you have multiple services that run to make up different parts of a bigger system, you can use docker-compose and create and start all these services with a simple configuration file.

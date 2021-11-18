import setuptools

setuptools.setup(
    name="dagster_capstone",
    packages=setuptools.find_packages(exclude=["dagster_capstone_tests"]),
    install_requires=[
        "dagster==0.13.5",
        "dagit==0.13.5",
        "pytest",
    ],
)

from flask import Flask

app = Flask(__name__)


@app.route("/hello_world")
def hello_world():
    """Sample of just posting text."""
    return "Hello, Docker!"


@app.route("/")
def index():
    """Main home page for app."""
    return "<h1>Hello!</h1>"


if __name__ == "__main__":
    app.run(debug=True)

from flask import Flask
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy

from app.config import Config

db = SQLAlchemy()


def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)

    CORS(app)
    db.init_app(app)

    from app.routes.health import health_bp
    from app.routes.items import items_bp

    app.register_blueprint(health_bp)
    app.register_blueprint(items_bp, url_prefix="/api")

    with app.app_context():
        db.create_all()

    return app

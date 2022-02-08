from sqlalchemy import (
    create_engine,
    Column,
    Integer,
)
from sqlalchemy.orm import (
    declarative_base,
    declared_attr,
)

import config


class Base:
    @declared_attr
    def __tablename__(cls):
        return f"blog_{cls.__name__.lower()}s"

    id = Column(Integer, primary_key=True)

    def __repr__(self):
        return str(self)


engine = create_engine(config.SQLALCHEMY_CONN_URL, echo=config.SQLALCHEMY_ECHO)
Base = declarative_base(bind=engine, cls=Base)

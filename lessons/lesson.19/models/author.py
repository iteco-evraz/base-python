from sqlalchemy import (
    Column,
    Integer,
    String,
    ForeignKey,
)
from sqlalchemy.orm import (
    relationship,
)

from .base import Base


class Author(Base):
    name = Column(String(64), unique=True)

    user_id = Column(Integer, ForeignKey("blog_users.id"), unique=True)
    user = relationship("User", back_populates="author")
    posts = relationship("Post", back_populates="author")

    def __str__(self):
        return (
            f"{self.__class__.__name__}("
            f"id={self.id}, "
            f"name={self.name!r}, "
            f"user_id={self.user_id})"
        )

from sqlalchemy import (
    Column,
    Integer,
    String,
    Text,
    ForeignKey,
)
from sqlalchemy.orm import (
    relationship,
)

from .base import Base


class Post(Base):
    title = Column(String(200), unique=False, nullable=False)
    body = Column(Text, default="", server_default="", nullable=False)

    author_id = Column(Integer, ForeignKey("blog_authors.id"), nullable=False)
    author = relationship("Author", back_populates="posts")

    def __str__(self):
        return (
            f"{self.__class__.__name__}("
            f"id={self.id}, "
            f"title={self.title!r}, "
            f"author_id={self.author_id})"
        )

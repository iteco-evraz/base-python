from sqlalchemy import Column, String, Boolean
from sqlalchemy.orm import relationship

from .base import Base
from .posts_tags import posts_tags_association_table


class Tag(Base):
    name = Column(String(16), unique=True, nullable=False)

    posts = relationship(
        "Post",
        secondary=posts_tags_association_table,
        back_populates="tags",
    )

    def __str__(self):
        return self.name

    def __repr__(self):
        return repr(str(self))

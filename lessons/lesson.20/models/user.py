from sqlalchemy import (
    Column,
    Integer,
    String,
    Boolean,
)
from sqlalchemy.orm import (
    relationship,
)

from .base import Base


class User(Base):
    username = Column(String(32), unique=True)
    is_staff = Column(Boolean, default=False, nullable=False)

    author = relationship("Author", back_populates="user", uselist=False)

    def __str__(self):
        return (
            f"{self.__class__.__name__}("
            f"id={self.id}, "
            f"username={self.username!r}, "
            f"is_staff={self.is_staff})"
        )

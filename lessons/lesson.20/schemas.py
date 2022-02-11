from pydantic import BaseModel


class BaseSchema(BaseModel):
    id: int

    class Config:
        orm_mode = True


class TagSchema(BaseSchema):
    name: str


class PostSchema(BaseSchema):
    title: str
    body: str
    author_id: int
    tags: list[TagSchema]

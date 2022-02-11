import falcon
from falcon import Request, Response
from sqlalchemy.orm import joinedload

from models import Post, Tag
from schemas import PostSchema


class PostsListResource:
    def on_get(self, req: Request, res: Response):
        posts: list[Post] = (
            req.context.session
            .query(Post)
            .options(joinedload(Post.tags))
            .all()
        )
        result = [
            PostSchema.from_orm(post).dict()
            for post in posts
        ]
        res.media = result


class PostDetailsResource:
    def on_get(self, req: Request, res: Response, post_id: str):
        post: Post = (
            req.context.session
            .get(
                Post,
                post_id,
                options=(
                    joinedload(Post.tags),
                )
            )
        )
        if post is None:
            res.status = falcon.HTTP_404
            result = {"message": f"post #{post_id} not found"}
        else:
            result = PostSchema.from_orm(post).dict()

        res.media = result


class PostDetailsAddTagResource:
    def on_post(self, req: Request, res: Response, post_id: str, tag_id: str):
        post: Post = (
            req.context.session
            .get(
                Post,
                post_id,
                options=(
                    joinedload(Post.tags),
                )
            )
        )
        if post is None:
            res.status = falcon.HTTP_404
            res.media = {"message": f"post #{post_id} not found"}
            return

        tag: Tag = (
            req.context.session
            .get(
                Tag,
                tag_id,
            )
        )
        if tag is None:
            res.status = falcon.HTTP_404
            res.media = {"message": f"tag #{tag_id} not found"}
            return

        for existing_tag in post.tags:  # type: Tag
            if existing_tag.id == tag.id:
                break
        else:
            post.tags.append(tag)

        res.media = PostSchema.from_orm(post).dict()
        # req.context.session.commit()

import falcon_sqla
from falcon import App

from models.base import engine
from posts_views import PostsListResource, PostDetailsResource, PostDetailsAddTagResource

manager = falcon_sqla.Manager(engine)

middlewares = [
    manager.middleware,
]

app = App(middleware=middlewares)

posts_list = PostsListResource()
post_details = PostDetailsResource()
post_details_add_tag = PostDetailsAddTagResource()

app.add_route("/posts", posts_list)
app.add_route("/posts/{post_id}", post_details)
app.add_route("/posts/{post_id}/tag/{tag_id}", post_details_add_tag)

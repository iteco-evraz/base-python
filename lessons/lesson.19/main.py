from sqlalchemy.orm import (
    Session as SessionType,
    scoped_session,
    sessionmaker,
)

from models import User, Author, Post
from models.base import engine

session_factory = sessionmaker(bind=engine)
Session = scoped_session(session_factory)


def create_user(session: SessionType, username: str) -> User:
    """
    :param session:
    :param username:
    :return:
    """
    user = User(username=username)
    print("create user", user)

    session.add(user)
    session.commit()

    print("saved user", user)

    return user


def create_author_for_user(
    session: SessionType,
    username: str,
    author_name: str,
):
    user = (
        session
        .query(User)
        .filter_by(username=username)
        .one()
    )
    author = Author(
        name=author_name,
        user=user,
    )
    print("create author", author, "for user", user)

    session.add(author)
    session.commit()

    print("saved author", author)
    print("author's user", author.user)
    print("author's user's author", author.user.author)


def create_posts_for_author_by_username(
    session: SessionType,
    username: str,
    *post_titles: str,
) -> list[Post]:
    """
    :param session:
    :param username:
    :param post_titles:
    :return:
    """
    author = (
        session
        .query(Author)
        .join(Author.user)
        .filter(User.username == username)
        .one()
    )
    for post_title in post_titles:
        post = Post(title=post_title, author=author)
        print("create post", post)
        session.add(post)

    session.commit()

    print("author's posts:", author.posts)
    return author.posts


def main():
    """
    :return:
    """
    # Base.metadata.create_all()  # NEVER
    session: SessionType = Session()
    # john = create_user(session, "john")
    # another_john = session.get(User, john.id)
    # print("another_john:", another_john)
    #
    # sam = create_user(session, "sam")
    # another_sam = session.get(User, sam.id)
    # print("another_sam:", another_sam)
    # session.refresh(sam)

    # create_author_for_user(session, "john", "John Smith")
    # create_author_for_user(session, "sam", "Sam White")

    create_posts_for_author_by_username(
        session,
        "john",
        "Django lesson",
        "Flask lesson",
    )

    create_posts_for_author_by_username(
        session,
        "sam",
        "PyCharm update",
        "Falcon news",
        "SQLAlchemy lesson",
    )

    session.close()


if __name__ == '__main__':
    main()

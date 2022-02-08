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
    user = User(username=username)
    print("create user", user)
    session.add(user)
    session.commit()
    print("added user", user)
    return user


def create_author_for_user(
    session: SessionType,
    username: str,
    author_name: str,
) -> Author:
    user = session.query(User).filter_by(username=username).one()
    author = Author(name=author_name, user=user)
    print("create author", author, "for user", user)
    session.add(author)
    session.commit()
    print("created author", author)
    print("author's user:", author.user)
    print("author's user's author:", author.user.author)
    return author


def create_posts_for_author_by_username(
    session: SessionType,
    username: str,
    *post_titles: str,
):
    author: Author = (
        session.query(Author)
        .join(Author.user)
        .filter(User.username == username)
        .one()
    )
    for post_title in post_titles:
        post = Post(title=post_title, author=author)
        session.add(post)

    session.commit()

    print("created posts for author", author)
    print("created posts:", author.posts)
    return author.posts


def main():
    """
    :return:
    """
    # Base.metadata.create_all()
    session: SessionType = Session()
    # john = create_user(session, "john")
    # print("john's username:", john.username)
    # sam = create_user(session, "sam")
    # print("sam's username:", sam.username)
    #
    # another_john = session.get(User, john.id)
    # print("another_john:", another_john)
    #
    # another_sam = session.get(User, sam.id)
    # print("another_sam:", another_sam)
    # # session.refresh(another_sam)

    # author = create_author_for_user(session, "john", "John Smith")
    # print("got author", author)
    # author = create_author_for_user(session, "sam", "Sam White")
    # print("got author", author)

    create_posts_for_author_by_username(
        session,
        "john",
        "Flask lesson",
        "Django lesson",
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

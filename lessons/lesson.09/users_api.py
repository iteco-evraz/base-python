import json

import falcon
from falcon import App, Request, Response

USERS = {
    1: "John",
    2: "Sam",
    3: "Nick",
}

# DAY_MINUTES = 24 * 60


class UsersListResource:
    def on_get(self, req: Request, res: Response):
        users_as_list = [
            {"id": user_id, "name": name}
            for user_id, name in USERS.items()
        ]
        res.text = json.dumps(users_as_list)

    def on_post(self, req: Request, res: Response):
        media: dict = req.get_media()
        data = json.loads(media["data"])

        try:
            user_id = int(data["id"])
            user_name = data["name"]
        except (ValueError, KeyError):
            res.status = falcon.HTTP_400
            result = {"message": "bad request"}
        else:
            if user_id in USERS:
                res.status = falcon.HTTP_400
                result = {"message": f"user with id #{user_id} already exists"}
            else:
                USERS[user_id] = user_name
                result = {"id": user_id, "name": user_name}
                res.status = falcon.HTTP_201

        # res.text = json.dumps({"message": "ok"})
        res.media = result


class UserDetailsResource:
    def on_get(self, req: Request, res: Response, user_id: str):
        try:
            user_id = int(user_id)
            name = USERS[user_id]
        except ValueError:
            res.status = falcon.HTTP_400
            result = {"message": f"not valid id {user_id!r}"}
        except KeyError:
            res.status = falcon.HTTP_404
            result = {"message": f"user #{user_id!r} not found"}
        else:
            result = {"id": user_id, "name": name}

        res.text = json.dumps(result)


users_list = UsersListResource()
user_details = UserDetailsResource()

app = App()

app.add_route("/users", users_list)
app.add_route("/users/{user_id}", user_details)


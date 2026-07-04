# JmespathFree SDK configuration


def make_config():
    return {
        "main": {
            "name": "JmespathFree",
        },
        "feature": {
            "test": {
        "options": {
          "active": False,
        },
      },
        },
        "options": {
            "base": "https://noteapiconnector-tools.vercel.app/api",
            "headers": {
        "content-type": "application/json",
      },
            "entity": {
                "jmes_path": {},
            },
        },
        "entity": {
      "jmes_path": {
        "fields": [
          {
            "active": True,
            "name": "data",
            "req": True,
            "type": "`$ANY`",
            "index$": 0,
          },
          {
            "active": True,
            "name": "query",
            "req": True,
            "type": "`$STRING`",
            "index$": 1,
          },
        ],
        "name": "jmes_path",
        "op": {
          "create": {
            "input": "data",
            "name": "create",
            "points": [
              {
                "active": True,
                "args": {},
                "method": "POST",
                "orig": "/jmespath",
                "parts": [
                  "jmespath",
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "index$": 0,
              },
            ],
            "key$": "create",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }

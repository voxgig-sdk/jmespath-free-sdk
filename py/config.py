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
            "name": "data",
            "req": True,
            "type": "`$ANY`",
            "active": True,
            "index$": 0,
          },
          {
            "name": "query",
            "req": True,
            "type": "`$STRING`",
            "active": True,
            "index$": 1,
          },
        ],
        "name": "jmes_path",
        "op": {
          "create": {
            "name": "create",
            "points": [
              {
                "method": "POST",
                "orig": "/jmespath",
                "parts": [
                  "jmespath",
                ],
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "active": True,
                "args": {},
                "select": {},
                "index$": 0,
              },
            ],
            "input": "data",
            "key$": "create",
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }

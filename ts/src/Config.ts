
import { BaseFeature } from './feature/base/BaseFeature'
import { TestFeature } from './feature/test/TestFeature'



const FEATURE_CLASS: Record<string, typeof BaseFeature> = {
   test: TestFeature,

}


class Config {

  makeFeature(this: any, fn: string) {
    const fc = FEATURE_CLASS[fn]
    const fi = new fc()
    // TODO: errors etc
    return fi
  }


  main = {
    name: 'JmespathFree',
  }


  feature = {
     test:     {
      "options": {
        "active": false
      }
    },

  }


  options = {
    base: "https://noteapiconnector-tools.vercel.app/api",

    headers: {
      "content-type": "application/json"
    },

    entity: {
      
      jmes_path: {
      },

    }
  }


  entity = {
    "jmes_path": {
      "fields": [
        {
          "name": "data",
          "req": true,
          "type": "`$ANY`",
          "union": {
            "branches": 2,
            "count": 1,
            "depth": 0
          }
        },
        {
          "name": "query",
          "req": true,
          "type": "`$STRING`"
        }
      ],
      "name": "jmes_path",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/jmespath",
              "parts": [
                "jmespath"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    }
  }
}


const config = new Config()

export {
  config
}


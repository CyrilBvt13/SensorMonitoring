from flask import Flask
from flask_restful import Api, Resource, reqparse
from tinydb import TinyDB, Query

app = Flask(__name__)
api = Api(app)
db = TinyDB('dbgarden.json')
query = Query()

route = "pigarden"

pigarden_args = reqparse.RequestParser()
pigarden_args.add_argument("timestamp", type=str, help="Timestamp is missing", required=True)
pigarden_args.add_argument("temperature", type=int, help="Temperature is missing", required=True)
pigarden_args.add_argument("pressure", type=int, help="Pressure is missing", required=True)
pigarden_args.add_argument("humidity", type=int, help="Humidity is missing", required=True)

class Item(Resource):
    def get(self, uid):
        return db.search(query.id == uid)

    def put(self, uid):
        args = pigarden_args.parse_args()
        db.insert({'id': uid, 'data':args})
        return db.search(query.id == uid), 201

    def patch(self, uid):
        args = pigarden_args.parse_args()
        db.update({'data':args}, query.id == uid)
        return db.search(query.id == uid), 201

    def delete(self, uid):
        db.remove(query.id == uid)
        return '', 204

api.add_resource(Item, "/"+route+"/<uid>")

if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=False)
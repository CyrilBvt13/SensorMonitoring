from flask import Flask
from flask_restful import Api, Resource, reqparse
from tinydb import TinyDB, Query
import uuid

project = "pigarden"

app = Flask(__name__)
api = Api(app)
db = TinyDB(project+'.json')
query = Query()

pigarden_args = reqparse.RequestParser()
pigarden_args.add_argument("timestamp", type=str, help="Timestamp is missing", required=True)
pigarden_args.add_argument("temperature", type=float, help="Temperature is missing", required=True)
pigarden_args.add_argument("pressure", type=float, help="Pressure is missing", required=True)
pigarden_args.add_argument("humidity", type=float, help="Humidity is missing", required=True)

class Items(Resource):
    def get(self):
        return db.all()

    def put(self):
        id = uuid.uuid4().hex
        args = pigarden_args.parse_args()
        db.insert({'id': id, 'data':args})
        return db.search(query.id == id), 201

class Item(Resource):
    def get(self, uid):
        return db.search(query.id == uid)

    def patch(self, uid):
        args = pigarden_args.parse_args()
        db.update({'data':args}, query.id == uid)
        return db.search(query.id == uid), 201

    def delete(self, uid):
        db.remove(query.id == uid)
        return '', 204

api.add_resource(Items, "/"+project+"/")
api.add_resource(Item, "/"+project+"/<uid>")

if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=False)

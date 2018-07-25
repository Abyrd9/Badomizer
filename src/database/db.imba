# Initialize Firebase
var db = null
var config = {
  apiKey: "AIzaSyAnTP38yl0z4We236D1MhqMqCIjW48ELjg"
  authDomain: "ignite-e4ee0.firebaseapp.com"
  databaseURL: "https://ignite-e4ee0.firebaseio.com"
  projectId: "ignite-e4ee0"
  storageBucket: "ignite-e4ee0.appspot.com"
  messagingSenderId: "665139466395"
}

window:firebase.initializeApp config
db = window:firebase.firestore
var settings = {timestampsInSnapshots: true}
db.settings settings

export class DB
  prop db

  def initialize
    @db = db

  def batch_insert collection, items
    var batch = @db.batch()

    for item in items
      batch.set(@db.collection(collection).doc(item:id), item)

    batch.commit()

  def get collection, id
    @db.collection(collection).doc(id).get()

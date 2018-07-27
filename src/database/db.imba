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

  def insert collection, id, item
    @db.collection(collection).doc(id).set(item)

  def batch_insert collection, revision, items
    var batch = @db.batch()
    batch.set(@db.collection(collection).doc(revision), { content: items })
    batch.commit()

  def get collection, id
    @db.collection(collection).doc(id).get()

  # Returns the collection as the pathname of the current page
  def get_page_collection
    window:location:pathname.replace("/", "_")

  def get_revisions page
    var querySnapshot = await @db.collection(page).get()

    if querySnapshot:size > 0
      var items = []
      querySnapshot.forEach do |doc|
        items.push doc.data

      items
    else
      []

  def format_contents contents
    if contents && contents:contents && contents:contents:length
      contents:contents.reduce do |content, acc|
        acc[content:id] = content
      , {}
    else
      {}

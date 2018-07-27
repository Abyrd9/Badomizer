import {DB} from "./database/db"
import {to_object} from "./util"
import {Editable} from "./admin/editable"
import {Admin} from "./admin/admin"

var store = {
	adminActive: false
	sidebarVisible: false
	contents: {}
}

# Get the current page revisions and put them in store
var db = DB.new
var contents = await db.get db.get_page_collection, "active"
if contents && contents.data && contents.data:content
	store:contents = to_object contents.data:content

var mounts = document.querySelectorAll("[data-editable]");
for mount in mounts
	var id = mount:dataset:contentId
	if not store:contents[id]
		store:contents[id] = {content: mount:innerHTML, id: id}

	Imba.mount <Editable[store] node=mount>, mount

var page_revisions = await db.get_revisions db.get_page_collection
store:revisions = page_revisions.filter do |i| i:id != "active"

Imba.mount <Admin[store]>
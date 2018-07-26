import {COLLECTION} from "./constants"
import {Editable} from "./admin/editable"
import {Admin} from "./admin/admin"

var store = {
	adminActive: false
	sidebarVisible: false
	contents: {}
}

var mounts = document.querySelectorAll("[data-editable]");
for mount in mounts
	var id = mount:dataset:contentId
	store:contents[id] = mount:innerHTML

	Imba.mount <Editable[store] node=mount>, mount

Imba.mount <Admin[store]>
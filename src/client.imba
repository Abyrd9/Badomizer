var store = {
	adminActive: false
	contents: {}
}

var COLLECTION = "contents"

tag App
	def build
		@db = window:db

	def create_styles
		var styles = document.getElementById "ignite-styles"

		# If styles are active remove them
		if styles && !data:adminActive
			styles.remove
		else if !styles && data:adminActive
			# Add styles back to the page
			var css = '
			[data-editable] {
				border: dashed 2px;
				box-shadow: inset 0 0 100px 100px rgba(255, 255, 255, 0.1);
			}
			'
			var head = document:head
			var style = document.createElement('style')

			style:id = "ignite-styles"
			style:type = "text/css"
			style.appendChild(document.createTextNode(css))
			head.appendChild(style)

	def save
		# Grab all the contents and their ids
		var mounts = document.querySelectorAll("[data-editable]");
		var batch = @db.batch()

		for mount in mounts
			var id = mount:dataset:contentId
			# do a small diff
			if data:contents[id] != mount:innerHTML
				batch.set(@db.collection(COLLECTION).doc(id), {content: mount:innerHTML})

		try
			var dat = await batch.commit()
		catch e
			console.log e

		data:adminActive = false

	def render
		create_styles

		<self>
			<div>
				<button :click=(do data:adminActive = !data:adminActive)> "Make stuff editable"
				if data:adminActive
					<button :click="save"> "Save"

tag Editable
	prop node

	def setup
		@db = window:db

		# Set the id based on the node contentid
		@id = @node:dataset:contentId

		# Replace the current node with an imba element
		@new_node = create_element(@node:outerHTML)

		# Grab the inner html for this editable and replace it
		try
			var contents = await @db.collection(COLLECTION).doc(@id).get()
			var results = contents.data()

			if results && results:content
				@new_node:innerHTML = results:content
		catch e
			console.log e

		@dom.appendChild @new_node

	def create_element str
		var div = document.createElement("div")
		div:innerHTML = str.trim()
		div:firstChild

	def mount
		@node.replaceWith(@dom)

	def render
		@dom:contentEditable = data:adminActive
		<self>

var mounts = document.querySelectorAll("[data-editable]");
for mount in mounts
	var id = mount:dataset:contentId
	store:contents[id] = mount:innerHTML

	Imba.mount <Editable[store] node=mount>, mount

Imba.mount <App[store]>
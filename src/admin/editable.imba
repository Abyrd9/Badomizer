import {COLLECTION} from "../constants"
import {DB} from "../database/db"

export tag Editable
	prop node

	def build
		@db = DB.new

	def setup
		# Set the id based on the node contentid
		@id = @node:dataset:contentId

		# Replace the current node with an imba element
		@new_node = create_element(@node:outerHTML)

		# Grab the inner html for this editable and replace it
		try
			var contents = await @db.get COLLECTION, @id
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
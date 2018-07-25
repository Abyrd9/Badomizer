import {COLLECTION} from "../constants"
import {DB} from "../database/db"

export tag Admin
	def build
		@db = DB.new

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

		var items = []
		for mount in mounts
			# do a small diff
			if data:contents[id] != mount:innerHTML
				items.push({
					id: mount:dataset:contentId
					content: mount:innerHTML
				})

		try
			await @db.batch_insert COLLECTION, items
		catch e
			console.log e

		data:adminActive = false

	def render
		create_styles

		<self>
			<div>
				<div
					:click=(do data:adminActive = !data:adminActive)
					css:border="solid 3px #000"
					css:backgroundRepeat="no-repeat"
    			css:backgroundSize="contain"
					css:backgroundImage="url('/images/edit.svg')"
					css:width="64px"
					css:height="64px"
					css:position="fixed"
					css:bottom="5px"
					css:right="5px"
				>
					""

				if data:adminActive
					<div
						css:border="solid 3px #000"
						css:backgroundRepeat="no-repeat"
						css:backgroundSize="contain"
						css:backgroundImage="url('/images/revision.svg')"
						css:width="64px"
						css:height="64px"
						css:position="fixed"
						css:bottom="151px"
						css:right="5px"
					>
						""
					<div
						:click="save"
						css:border="solid 3px #000"
						css:backgroundRepeat="no-repeat"
						css:backgroundSize="contain"
						css:backgroundImage="url('/images/save.svg')"
						css:width="64px"
						css:height="64px"
						css:position="fixed"
						css:bottom="78px"
						css:right="5px"
					>
						""
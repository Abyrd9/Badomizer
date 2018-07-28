import {AdminButtons} from "./admin-buttons"
import {Sidebar} from "./sidebar"

export tag Admin
	def create_styles
		var styles = document.getElementById "ignite-styles"
		var defaultStyles = document.getElementById "badomizer-base-styles"

		# Add the base styles
		if !defaultStyles
			var head = document:head
			var style = document.createElement('style')

			style:id = "badomizer-base-styles"
			style:type = "text/css"
			style.appendChild(document.createTextNode(css))
			head.appendChild(style)

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
			.remove {

			}
			'
			var head = document:head
			var style = document.createElement('style')

			style:id = "ignite-styles"
			style:type = "text/css"
			style.appendChild(document.createTextNode(css))
			head.appendChild(style)

	def render
		create_styles

		<self>
			<div>
				<Sidebar[data]>
				<AdminButtons[data]>
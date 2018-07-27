import {DB} from "../database/db"

export tag AdminButtons
  def build
    @db = DB.new

  def toggle_sidebar
    data:sidebarVisible = !data:sidebarVisible

  def save
    # Grab all the contents and their ids
    var mounts = document.querySelectorAll("[data-editable]");

    var items = []
    for mount in mounts
      items.push({
        id: mount:dataset:contentId
        content: mount:innerHTML
      })

    try
      var revisions = "1"
      if data:revisions && data:revisions:length
        revisions = (data:revisions:length + 1).toString
      # Insert the revision number and change active to this new revision
      await @db.insert @db.get_page_collection, revisions, { content: items, id: revisions, date: Date.new }
      await @db.insert @db.get_page_collection, "active", { content: items, id: "active", data: Date.new }
    catch e
      console.log e

    data:adminActive = false

  def render
    <self>
      <div.admin-buttons>
        if data:adminActive
          <div.admin-button
            css:backgroundImage="url('/images/publish.svg')"
          >
            ""
          <div.admin-button
            :click="toggle_sidebar"
            css:backgroundImage="url('/images/revision.svg')"
          >
            ""
          <div.admin-button
            :click="save"
            css:backgroundImage="url('/images/save.svg')"
          >
            ""
        <div.admin-button
          :click=(do data:adminActive = !data:adminActive)
          css:backgroundImage="url('/images/edit.svg')"
        >
          ""
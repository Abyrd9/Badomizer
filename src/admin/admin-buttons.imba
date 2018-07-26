import {COLLECTION} from "../constants"
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
    <self>
      <div.admin-buttons>
        if data:adminActive
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
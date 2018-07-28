import {DB} from "../database/db"

export tag Sidebar
  def build
    @db = DB.new

  def format_date date
    var d = Date.new (date * 1000)
    "{d.getMonth}/{d.getDate}/{d.getFullYear} {d.getHours}:{d.getMinutes}"

  def make_active
    var revision_id = data:selectedRevision
    var revision = data:revisions.find do |r|
      r:id == revision_id

    var active_revision = Object.assign {}, revision, {id: "active"}
    await @db.insert @db.get_page_collection, "active", active_revision
    window:location.reload

  def render
    <self>
      <div.sidebar .visible=data:sidebarVisible>
        <i.fas .fa-times .sidebar__close-icon :click=(do data:sidebarVisible = false)>
        <select[data:selectedRevision] .sidebar__select>
          <option.sidebar__select__option> "Revision Date"
          for revision in data:revisions
            <option value=revision:id>
              "{revision:id}-{format_date revision:date:seconds}"
        <button.sidebar__button :click="make_active"> "Make Active"
export tag Sidebar
  def render
    <self>
      <div.sidebar.sidebar-visible=data:sidebarVisible>
        <div.remove :click=(do data:sidebarVisible = false)>
        "I am the sidebar"
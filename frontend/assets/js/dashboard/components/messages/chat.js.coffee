document.addEventListener 'DOMContentLoaded', ->
  sidebar = document.querySelector('.sidebar')
  toggleBtn = document.getElementById('sidebar-toggle')
  conversationPanel = document.getElementById('conversation-panel')
  extrasPanel = document.getElementById('extras-panel')
  searchInput = document.getElementById('search-messages')
  extrasBtn = document.getElementById('extras-btn')
  messageList = document.getElementById('message-list')
  autocompleteDropdown = document.getElementById('autocomplete-dropdown')
  sendIcon = document.getElementById('send-icon')
  settingsBtn = document.getElementById('settings-btn')
  settingsDropdown = document.getElementById('settings-dropdown')
  contacts = ['Nimbus AI', 'User1', 'User2', 'Emmanuel-Moore', 'John-Doe']
  selectedContact = 'Nimbus AI'

  # Toggle sidebar collapse/expand
  unless toggleBtn
    console?.log 'Toggle button not found'
    return
  toggleBtn.addEventListener 'click', ->
    unless sidebar
      console?.log 'Sidebar not found'
      return
    sidebar.classList.toggle('collapsed')
    isCollapsed = sidebar.classList.contains('collapsed')
    sidebar.querySelectorAll('.nav-item').forEach (item) ->
      span = item.querySelector('span')
      if span
        span.style.opacity = if isCollapsed then '0' else '1'
        span.style.width = if isCollapsed then '0' else 'auto'
    mainContent = document.querySelector('.main-content')
    unless mainContent
      console?.log 'Main content not found'
      return
    mainContent.style.marginLeft = if isCollapsed then '64px' else '200px'
    console?.log "Sidebar toggled, collapsed: #{isCollapsed}"

  # Filter contacts and handle @ mention autocomplete
  searchInput.addEventListener 'input', ->
    query = searchInput.value.toLowerCase()
    messageList.innerHTML = ''
    filteredContacts = contacts.filter (contact) ->
      contact.toLowerCase().includes(query)
    filteredContacts.forEach (contact) ->
      item = document.createElement('div')
      item.className = 'message-item flex justify-between items-center p-2 bg-gray-700/50 rounded hover:bg-purple-600/50 transition cursor-pointer relative'
      item.dataset.contact = contact
      item.innerHTML = """
        <div class="flex items-center">
          <div class="w-12 h-12 bg-gray-600 rounded-full flex items-center justify-center mr-3 text-white font-bold">#{contact[0]}</div>
          <div>
            <div class="text-white font-medium">#{contact}</div>
            <div class="text-gray-400 text-sm">Snippet of message...</div>
          </div>
        </div>
        <div class="flex items-center space-x-2">
          <span class="text-gray-500 text-xs">2h ago</span>
          #{if contact == 'Nimbus AI' then '<span class="w-3 h-3 bg-purple-500 rounded-full animate-pulse"></span>' else ''}
        </div>
        <div id="tooltip-#{contact.replace(/[^a-zA-Z0-9]/g, '')}" class="absolute hidden bg-gray-700 text-white p-2 rounded-lg shadow-lg z-10 w-48">
          <p><strong>Name:</strong> #{contact}</p>
          <p><strong>Last Active:</strong> 5m ago</p>
          <p><strong>Status:</strong> Online</p>
        </div>
      """
      item.addEventListener 'mouseover', ->
        tooltip = item.querySelector("div[id='tooltip-#{contact.replace(/[^a-zA-Z0-9]/g, '')}']")
        tooltip.style.display = 'block'
      item.addEventListener 'mouseout', ->
        tooltip = item.querySelector("div[id='tooltip-#{contact.replace(/[^a-zA-Z0-9]/g, '')}']")
        tooltip.style.display = 'none'
      item.addEventListener 'click', ->
        selectedContact = contact
        # Update conversation panel here if needed
      messageList.appendChild(item)

    # Handle @ mention autocomplete
    if query.startsWith('@')
      mentionQuery = query.slice(1)
      filteredUsers = contacts.filter((contact) -> contact.toLowerCase().includes(mentionQuery) and contact != selectedContact)
      if filteredUsers.length > 0
        autocompleteDropdown.innerHTML = ''
        filteredUsers.slice(0, 5).forEach (user) ->
          option = document.createElement('div')
          option.className = 'px-4 py-2 text-gray-300 hover:bg-purple-600/50 cursor-pointer flex items-center'
          option.innerHTML = """
            <div class="w-8 h-8 bg-gray-600 rounded-full flex items-center justify-center mr-2 text-white font-bold">#{user[0]}</div>
            <span>#{user}</span>
          """
          option.addEventListener 'click', ->
            searchInput.value = "@#{user} "
            autocompleteDropdown.classList.add('hidden')
            sendIcon.classList.remove('hidden')
          autocompleteDropdown.appendChild(option)
        autocompleteDropdown.classList.remove('hidden')
      else
        autocompleteDropdown.classList.add('hidden')
    else
      autocompleteDropdown.classList.add('hidden')
      sendIcon.classList.add('hidden')

  # Populate initial message list
  searchInput.dispatchEvent(new Event('input'))

  # Send message when send icon is clicked
  sendIcon.addEventListener 'click', ->
    message = searchInput.value.trim()
    if message.startsWith('@') and message.includes(' ')
      recipient = message.split(' ')[0].slice(1)
      content = message.split(' ').slice(1).join(' ')
      if contacts.includes(recipient)
        console.log "Sending message to #{recipient}: #{content}"
        searchInput.value = ''
        sendIcon.classList.add('hidden')
        # Add logic to send message via API or update UI
    autocompleteDropdown.classList.add('hidden')

  # Toggle Extras panel
  extrasBtn.addEventListener 'click', ->
    conversationPanel.style.display = 'none'
    extrasPanel.style.display = 'block'

  # Back to conversation from Extras
  backBtn = extrasPanel.querySelector('button[onclick="showConversation()"]')
  if backBtn
    backBtn.addEventListener 'click', ->
      conversationPanel.style.display = 'block'
      extrasPanel.style.display = 'none'

  # Toggle settings dropdown
  settingsBtn.addEventListener 'click', ->
    settingsDropdown.classList.toggle('hidden')

  window.showExtras = -> extrasBtn.click()
  window.clearMessages = ->
    messageList.innerHTML = ''
    settingsDropdown.classList.add('hidden')

document.addEventListener 'DOMContentLoaded', ->
  searchInput = document.getElementById 'search-messages'
  settingsBtn = document.getElementById 'settings-btn'
  messageList = document.getElementById 'message-list'
  contacts = ['Nimbus AI', 'User1', 'User2']
  selectedContact = 'Nimbus AI'

  searchInput.addEventListener 'input', ->
    query = searchInput.value.toLowerCase()
    messageList.innerHTML = ''
    filteredContacts = contacts.filter (contact) -> contact.toLowerCase().includes(query)
    for contact in filteredContacts
      isNew = contact is 'Nimbus AI'
      isSelected = contact is selectedContact
      item = document.createElement 'div'
      item.className = "message-item flex justify-between items-center p-2 bg-gray-700/50 rounded #{if isSelected then 'bg-purple-600/50' else 'hover:bg-purple-600/50'} transition cursor-pointer"
      item.dataset.contact = contact
      item.innerHTML = """
        <div class="flex items-center">
          <div class="w-12 h-12 bg-gray-600 rounded-full flex items-center justify-center mr-3 text-white font-bold">#{contact.slice(0,1)}</div>
          <div>
            <div class="text-white font-medium">#{contact}</div>
            <div class="text-gray-400 text-sm">Snippet of message...</div>
          </div>
        </div>
        <div class="flex items-center space-x-2">
          <span class="text-gray-500 text-xs">2h ago</span>
          #{if isNew then '<span class="w-3 h-3 bg-purple-500 rounded-full animate-pulse"></span>' else ''}
        </div>
      """
      item.addEventListener 'click', -> 
        selectedContact = contact
        document.getElementById('current-contact').textContent = contact
        conversationBody = document.getElementById 'conversation-body'
        conversationBody.innerHTML = ''
        fetch('/api/messages/history', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ contact })
        })
        .then((response) => response.json())
        .then((data) => 
          for msg in data.messages
            addMessageToConversation msg.sender, msg.content, msg.time
        )
      messageList.appendChild item
    searchInput.dispatchEvent new Event('input')

  settingsBtn.addEventListener 'click', ->
    window.location.href = window.messagesConfig.settingsUrl

  addMessageToConversation = (sender, message, time) ->
    bubbleClass = if sender is 'You' then 'sent-right bg-gradient-to-r from-purple-600 to-pink-500' else 'sender-left bg-gray-700'
    messageDiv = document.createElement 'div'
    messageDiv.className = "message-bubble #{bubbleClass} text-white p-3 rounded-lg max-w-md #{if sender is 'You' then 'self-end' else ''}"
    messageDiv.innerHTML = """
      <div class="text-xs text-gray-#{if sender is 'You' then '200' else '400'}">#{time}</div>
      <div>#{message}</div>
    """
    document.getElementById('conversation-body').appendChild messageDiv
    document.getElementById('conversation-body').scrollTop = document.getElementById('conversation-body').scrollHeight

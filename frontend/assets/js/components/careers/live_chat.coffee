document.addEventListener 'DOMContentLoaded', ->
  # Elements
  chatToggle = document.getElementById('chat-toggle')
  chatWindow = document.getElementById('chat-window')
  chatClose = document.getElementById('chat-close')
  chatMessages = document.getElementById('chat-messages')
  chatInput = document.getElementById('chat-input')

  # Live Chat with WebSocket
  ws = new WebSocket('ws://localhost:8080') # Placeholder WebSocket URL
  ws.onopen = ->
    addChatMessage('System', 'Connected to Aviyon Support. How can we assist you?')

  ws.onmessage = (event) ->
    data = JSON.parse(event.data)
    addChatMessage('Support', data.message)

  ws.onclose = ->
    addChatMessage('System', 'Chat disconnected. Please refresh to reconnect.')

  addChatMessage = (sender, message) ->
    msgDiv = document.createElement('div')
    msgDiv.className = if sender is 'You' then 'text-right' else 'text-left'
    msgDiv.innerHTML = """
      <p class="text-sm text-gray-400">#{sender}</p>
      <p class="bg-#{if sender is 'You' then 'neon-purple' else 'gray-700'} text-white p-2 rounded-lg inline-block">#{message}</p>
    """
    chatMessages.appendChild(msgDiv)
    chatMessages.scrollTop = chatMessages.scrollHeight

  chatToggle.addEventListener 'click', ->
    chatWindow.classList.toggle('hidden')

  chatClose.addEventListener 'click', ->
    chatWindow.classList.add('hidden')

  chatInput.addEventListener 'keypress', (e) ->
    if e.key is 'Enter' and chatInput.value.trim() isnt ''
      message = chatInput.value
      addChatMessage('You', message)
      ws.send(JSON.stringify({ message: message }))
      chatInput.value = ''

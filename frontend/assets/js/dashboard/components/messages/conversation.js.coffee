document.addEventListener 'DOMContentLoaded', ->
  messageInput = document.getElementById 'message-input'
  sendMessageBtn = document.getElementById 'send-message'
  conversationBody = document.getElementById 'conversation-body'
  voiceCallBtn = document.getElementById 'voice-call-btn'
  scheduleMeetingBtn = document.getElementById 'schedule-meeting-btn'
  themeSelect = document.getElementById 'theme-select'
  currentContact = document.getElementById('current-contact').textContent

  addMessage = (sender, message, time) ->
    bubbleClass = if sender is 'You' then 'sent-right bg-gradient-to-r from-purple-600 to-pink-500' else 'sender-left bg-gray-700'
    messageDiv = document.createElement 'div'
    messageDiv.className = "message-bubble #{bubbleClass} text-white p-3 rounded-lg max-w-md #{if sender is 'You' then 'self-end' else ''}"
    messageDiv.innerHTML = """
      <div class="text-xs text-gray-#{if sender is 'You' then '200' else '400'}">#{time}</div>
      <div>#{message}</div>
    """
    conversationBody.appendChild messageDiv
    conversationBody.scrollTop = conversationBody.scrollHeight

  sendMessage = ->
    message = messageInput.value.trim()
    return unless message
    currentTime = new Date().toLocaleString('en-US', { hour: '2-digit', minute: '2-digit', hour12: true, month: 'short', day: 'numeric', year: 'numeric' })
    addMessage 'You', message, currentTime
    messageInput.value = ''
    fetch('/api/messages/send', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ sender: 'You', receiver: currentContact, message })
    })
    .then((response) => response.json())
    .then((data) => 
      setTimeout ->
        addMessage currentContact, data.response, new Date().toLocaleString('en-US', { hour: '2-digit', minute: '2-digit', hour12: true, month: 'short', day: 'numeric', year: 'numeric' })
      , 1000
    )

  sendMessageBtn.addEventListener 'click', sendMessage
  messageInput.addEventListener 'keypress', (e) -> sendMessage() if e.key is 'Enter'

  voiceCallBtn.addEventListener 'click', -> alert 'Initiating voice call with WebRTC (to be implemented)'
  scheduleMeetingBtn.addEventListener 'click', -> window.location.href = window.messagesConfig.calendarUrl

  themeSelect.addEventListener 'change', (e) ->
    document.body.className = e.target.value
    fetch('/api/settings/theme', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ theme: e.target.value })
    })

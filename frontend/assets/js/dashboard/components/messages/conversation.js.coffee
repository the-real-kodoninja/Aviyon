document.addEventListener 'DOMContentLoaded', ->
  messageInput = document.getElementById 'message-input'
  sendMessageBtn = document.getElementById 'send-message'
  conversationBody = document.getElementById 'conversation-body'
  voiceCallBtn = document.getElementById 'voice-call-btn'
  videoCallBtn = document.getElementById 'video-call-btn'
  infoBtn = document.getElementById 'info-btn'
  userTooltip = document.getElementById 'user-tooltip'
  infoTooltip = document.getElementById 'info-tooltip'
  currentContact = 'Nimbus AI'

  addMessage = (sender, message, time, status = 'Sent') ->
    bubbleClass = if sender is 'You' then 'sent-right bg-gradient-to-r from-purple-600 to-pink-500' else 'sender-left bg-gray-700'
    statusText = switch status
      when 'Sent' then ''
      when 'Read' then '<span class="text-green-500 ml-2">✓ Read</span>'
      when 'Seen' then '<span class="text-green-500 ml-2">✓✓ Seen</span>'
    messageDiv = document.createElement 'div'
    messageDiv.className = "message-bubble #{bubbleClass} text-white p-3 rounded-lg max-w-md #{if sender is 'You' then 'self-end' else ''}"
    messageDiv.innerHTML = """
      <div class="text-xs text-gray-#{if sender is 'You' then '200' else '400'}">#{time} #{statusText}</div>
      <div>#{message}</div>
    """
    conversationBody.appendChild messageDiv
    conversationBody.scrollTop = conversationBody.scrollHeight

  sendMessage = ->
    message = messageInput.value.trim()
    return unless message
    currentTime = new Date().toLocaleString('en-US', { hour: '2-digit', minute: '2-digit', hour12: true, month: 'short', day: 'numeric', year: 'numeric' })
    addMessage 'You', message, currentTime, 'Sent'
    messageInput.value = ''
    fetch('/api/messages/send', {
      method: 'POST'
      headers: { 'Content-Type': 'application/json' }
      body: JSON.stringify({ sender: 'You', receiver: currentContact, message })
    })
    .then((response) => response.json())
    .then((data) =>
      setTimeout ->
        addMessage currentContact, data.response, new Date().toLocaleString('en-US', { hour: '2-digit', minute: '2-digit', hour12: true, month: 'short', day: 'numeric', year: 'numeric' }), 'Seen'
      , 1000
    )

  sendMessageBtn.addEventListener 'click', sendMessage
  messageInput.addEventListener 'keypress', (e) -> sendMessage() if e.key is 'Enter'

  # Voice call functionality
  voiceCallBtn.addEventListener 'click', ->
    alert 'Initiating voice call with WebRTC (to be implemented). Connecting to Nimbus AI...'
    # Placeholder for WebRTC implementation

  # Video call functionality
  videoCallBtn.addEventListener 'click', ->
    alert 'Initiating video call with WebRTC (to be implemented). Connecting to Nimbus AI...'
    # Placeholder for WebRTC implementation

  # User tooltip on hover
  userContainer = document.querySelector('.flex.items-center:first-child')
  userContainer.addEventListener 'mouseover', ->
    userTooltip.style.display = 'block'
  userContainer.addEventListener 'mouseout', ->
    userTooltip.style.display = 'none'

  # Info tooltip on hover
  infoBtn.addEventListener 'mouseover', ->
    infoTooltip.style.display = 'block'
  infoBtn.addEventListener 'mouseout', ->
    infoTooltip.style.display = 'none'

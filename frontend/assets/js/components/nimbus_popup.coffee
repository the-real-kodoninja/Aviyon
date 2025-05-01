NimbusPopup =
  getElement: (id) ->
    try
      element = document.getElementById(id)
      throw new Error("Element with ID #{id} not found") unless element
      element
    catch e
      console.error '[NimbusPopup] Error:', e.message
      null

  thunderheadActive: false

  # Make Chat Icon Draggable
  initIconDragging: ->
    chatIcon = @getElement('chat-icon')
    return unless chatIcon

    iconDragging = false
    iconX = 0
    iconY = 0

    chatIcon.addEventListener 'mousedown', (e) =>
      iconDragging = true
      rect = chatIcon.getBoundingClientRect()
      iconX = e.clientX - rect.left
      iconY = e.clientY - rect.top
      document.addEventListener 'mousemove', @onIconDrag
      document.addEventListener 'mouseup', @stopIconDrag

  onIconDrag: (e) =>
    chatIcon = @getElement('chat-icon')
    return unless chatIcon

    if @iconDragging
      newX = e.clientX - @iconX
      newY = e.clientY - @iconY
      chatIcon.style.left = "#{newX}px"
      chatIcon.style.top = "#{newY}px"
      chatIcon.style.right = 'auto'
      chatIcon.style.bottom = 'auto'

  stopIconDrag: =>
    @iconDragging = false
    document.removeEventListener 'mousemove', @onIconDrag
    document.removeEventListener 'mouseup', @stopIconDrag

  # Open Chat Popup with Dynamic Positioning
  openChatPopup: ->
    chatIcon = @getElement('chat-icon')
    chatPopup = @getElement('chat-popup')
    return unless chatIcon and chatPopup

    iconRect = chatIcon.getBoundingClientRect()
    popupWidth = chatPopup.offsetWidth
    popupHeight = chatPopup.offsetHeight
    viewportWidth = window.innerWidth
    viewportHeight = window.innerHeight

    # Determine position based on icon location
    isTopHalf = iconRect.top < viewportHeight / 2
    isLeftHalf = iconRect.left < viewportWidth / 2

    if isTopHalf
      # Open below the icon
      chatPopup.style.top = "#{iconRect.bottom + 16}px"
      chatPopup.style.bottom = 'auto'
    else
      # Open above the icon
      chatPopup.style.bottom = "#{viewportHeight - iconRect.top + 16}px"
      chatPopup.style.top = 'auto'

    if isLeftHalf
      # Open to the right of the icon
      chatPopup.style.left = "#{iconRect.right + 16}px"
      chatPopup.style.right = 'auto'
    else
      # Open to the left of the icon
      chatPopup.style.right = "#{viewportWidth - iconRect.left + 16}px"
      chatPopup.style.left = 'auto'

    chatPopup.classList.remove('hidden')
    chatIcon.classList.add('hidden')

  # Close Chat Popup
  closeChatPopup: ->
    chatPopup = @getElement('chat-popup')
    chatIcon = @getElement('chat-icon')
    menuDropdown = @getElement('menu-dropdown')
    menuMain = @getElement('menu-main')
    nimbusAgentSection = @getElement('nimbus-agent-section')
    settingsSection = @getElement('settings-section')
    threadsSection = @getElement('threads-section')
    return unless chatPopup and chatIcon and menuDropdown and menuMain and nimbusAgentSection and settingsSection and threadsSection

    chatPopup.classList.add('hidden')
    chatIcon.classList.remove('hidden')
    menuDropdown.classList.add('hidden')
    menuMain.classList.remove('hidden')
    nimbusAgentSection.classList.add('hidden')
    settingsSection.classList.add('hidden')
    threadsSection.classList.add('hidden')
    @thunderheadActive = false

  # Make Chat Popup Draggable
  initPopupDragging: ->
    chatPopup = @getElement('chat-popup')
    return unless chatPopup

    popupDragging = false
    popupX = 0
    popupY = 0

    chatPopup.addEventListener 'mousedown', (e) =>
      if e.target.closest('.p-3.bg-gray-800.border-b.border-gray-700') # Only drag from header
        popupDragging = true
        rect = chatPopup.getBoundingClientRect()
        popupX = e.clientX - rect.left
        popupY = e.clientY - rect.top
        document.addEventListener 'mousemove', @onPopupDrag
        document.addEventListener 'mouseup', @stopPopupDrag

  onPopupDrag: (e) =>
    chatPopup = @getElement('chat-popup')
    return unless chatPopup

    if @popupDragging
      newX = e.clientX - @popupX
      newY = e.clientY - @popupY
      chatPopup.style.left = "#{newX}px"
      chatPopup.style.top = "#{newY}px"
      chatPopup.style.right = 'auto'
      chatPopup.style.bottom = 'auto'

  stopPopupDrag: =>
    @popupDragging = false
    document.removeEventListener 'mousemove', @onPopupDrag
    document.removeEventListener 'mouseup', @stopPopupDrag

  # Update Word Count
  updateWordCount: ->
    chatInput = @getElement('chat-input')
    wordCount = @getElement('word-count')
    return unless chatInput and wordCount

    words = chatInput.value.trim().split(/\s+/).filter((word) -> word.length > 0)
    wordCount.textContent = "Word Count: #{words.length}"

  # Handle Chat Submission
  handleChatSubmission: ->
    chatInput = @getElement('chat-input')
    chatMessages = document.querySelector('.chat-messages')
    responseIndicator = @getElement('response-indicator')
    return unless chatInput and chatMessages and responseIndicator

    message = chatInput.value.trim()
    return unless message

    # Add user message
    userMessage = document.createElement('div')
    userMessage.className = 'message user-message flex justify-end items-start space-x-2'
    userMessage.innerHTML = """
      <div class="relative bg-purple-500 text-white p-2 rounded-lg max-w-xs">
          #{message}
          <div class="message-actions absolute top-0 right-0 flex space-x-1 p-1 opacity-0 transition-opacity">
              <button class="edit-btn text-gray-200 hover:text-purple-300">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                  </svg>
              </button>
              <button class="copy-btn text-gray-200 hover:text-purple-300">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                  </svg>
              </button>
          </div>
      </div>
      <img src="/build/images/users/current_user.png" alt="User" class="w-8 h-8 rounded-full">
    """
    chatMessages.appendChild(userMessage)
    chatInput.value = ''
    @updateWordCount()

    # Scroll to the bottom
    chatMessages.scrollTop = chatMessages.scrollHeight

    # Show response indicator
    responseMessages = [
      'nimbus.ai is responding'
      'nimbus.ai is researching'
      'nimbus.ai is thinking'
      'nimbus.ai is analyzing'
    ]
    indicatorText = if @thunderheadActive then 'nimbus.ai is asking the Thunderhead' else responseMessages[Math.floor(Math.random() * responseMessages.length)]
    responseIndicator.textContent = indicatorText
    responseIndicator.classList.remove('hidden')

    # Simulate AI response (replace with API call later)
    setTimeout =>
      responseIndicator.classList.add('hidden')
      aiMessage = document.createElement('div')
      aiMessage.className = 'message ai-message flex justify-start items-start space-x-2'
      aiMessage.innerHTML = """
        <img src="/build/images/nimbus-ai.png" alt="Nimbus AI" class="w-8 h-8 rounded-full">
        <div class="relative bg-gray-700 text-gray-100 p-2 rounded-lg max-w-xs">
            I’m here to help! What would you like to know about?
            <div class="message-actions absolute top-0 right-0 flex space-x-1 p-1 opacity-0 transition-opacity">
                <button class="refresh-btn text-gray-200 hover:text-purple-300">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9H3m17 8h-5.582a8.001 8.001 0 001.356-8H21"></path>
                    </svg>
                </button>
                <button class="continue-btn text-gray-200 hover:text-purple-300">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 5l7 7-7 7M5 5l7 7-7 7"></path>
                    </svg>
                </button>
                <button class="copy-btn text-gray-200 hover:text-purple-300">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                    </svg>
                </button>
                <button class="share-btn text-gray-200 hover:text-purple-300">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.368 2.684 3 3 0 00-5.368-2.684z"></path>
                    </svg>
                </button>
            </div>
        </div>
      """
      chatMessages.appendChild(aiMessage)
      chatMessages.scrollTop = chatMessages.scrollHeight
      @thunderheadActive = false

      # Add event listeners for message actions
      userMessage.querySelector('.copy-btn').addEventListener 'click', =>
        navigator.clipboard.writeText(message)
        alert('Message copied to clipboard!')

      userMessage.querySelector('.edit-btn').addEventListener 'click', =>
        newMessage = prompt('Edit your message:', message)
        if newMessage
          userMessage.querySelector('div > div').childNodes[0].textContent = newMessage

      setTimeout =>
        aiMessage = chatMessages.lastElementChild
        aiMessage.querySelector('.copy-btn').addEventListener 'click', =>
          navigator.clipboard.writeText(aiMessage.querySelector('div > div').childNodes[0].textContent)
          alert('Response copied to clipboard!')

        aiMessage.querySelector('.refresh-btn').addEventListener 'click', =>
          responseIndicator.textContent = 'nimbus.ai is refreshing'
          responseIndicator.classList.remove('hidden')
          setTimeout =>
            responseIndicator.classList.add('hidden')
            aiMessage.querySelector('div > div').childNodes[0].textContent = 'Refreshed response!'
            chatMessages.scrollTop = chatMessages.scrollHeight
          , 1000

        aiMessage.querySelector('.continue-btn').addEventListener 'click', =>
          responseIndicator.textContent = 'nimbus.ai is continuing'
          responseIndicator.classList.remove('hidden')
          setTimeout =>
            responseIndicator.classList.add('hidden')
            continueMessage = document.createElement('div')
            continueMessage.className = 'message ai-message flex justify-start items-start space-x-2'
            continueMessage.innerHTML = """
              <img src="/build/images/nimbus-ai.png" alt="Nimbus AI" class="w-8 h-8 rounded-full">
              <div class="relative bg-gray-700 text-gray-100 p-2 rounded-lg max-w-xs">
                  Continuing the conversation...
                  <div class="message-actions absolute top-0 right-0 flex space-x-1 p-1 opacity-0 transition-opacity">
                      <button class="refresh-btn text-gray-200 hover:text-purple-300">
                          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9H3m17 8h-5.582a8.001 8.001 0 001.356-8H21"></path>
                          </svg>
                      </button>
                      <button class="continue-btn text-gray-200 hover:text-purple-300">
                          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 5l7 7-7 7M5 5l7 7-7 7"></path>
                          </svg>
                      </button>
                      <button class="copy-btn text-gray-200 hover:text-purple-300">
                          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                          </svg>
                      </button>
                      <button class="share-btn text-gray-200 hover:text-purple-300">
                          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.368 2.684 3 3 0 00-5.368-2.684z"></path>
                          </svg>
                      </button>
                  </div>
              </div>
            """
            chatMessages.appendChild(continueMessage)
            chatMessages.scrollTop = chatMessages.scrollHeight
          , 1000

        aiMessage.querySelector('.share-btn').addEventListener 'click', =>
          alert('Share functionality not implemented yet.')
      , 1000
    , 1000

  # Thunderhead Button
  handleThunderhead: ->
    responseIndicator = @getElement('response-indicator')
    chatMessages = document.querySelector('.chat-messages')
    return unless responseIndicator and chatMessages

    @thunderheadActive = true
    responseIndicator.textContent = 'nimbus.ai is asking the Thunderhead'
    responseIndicator.classList.remove('hidden')

    setTimeout =>
      responseIndicator.classList.add('hidden')
      aiMessage = document.createElement('div')
      aiMessage.className = 'message ai-message flex justify-start items-start space-x-2'
      aiMessage.innerHTML = """
        <img src="/build/images/nimbus-ai.png" alt="Nimbus AI" class="w-8 h-8 rounded-full">
        <div class="relative bg-gray-700 text-gray-100 p-2 rounded-lg max-w-xs">
            Thunderhead response: I’ve got some insights for you!
            <div class="message-actions absolute top-0 right-0 flex space-x-1 p-1 opacity-0 transition-opacity">
                <button class="refresh-btn text-gray-200 hover:text-purple-300">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9H3m17 8h-5.582a8.001 8.001 0 001.356-8H21"></path>
                    </svg>
                </button>
                <button class="continue-btn text-gray-200 hover:text-purple-300">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 5l7 7-7 7M5 5l7 7-7 7"></path>
                    </svg>
                </button>
                <button class="copy-btn text-gray-200 hover:text-purple-300">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z"></path>
                    </svg>
                </button>
                <button class="share-btn text-gray-200 hover:text-purple-300">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.368 2.684 3 3 0 00-5.368-2.684z"></path>
                    </svg>
                </button>
            </div>
        </div>
      """
      chatMessages.appendChild(aiMessage)
      chatMessages.scrollTop = chatMessages.scrollHeight
      @thunderheadActive = false
    , 1000

  # Menu Dropdown Toggle
  toggleMenuDropdown: (e) ->
    menuDropdown = @getElement('menu-dropdown')
    return unless menuDropdown

    e.stopPropagation()
    menuDropdown.classList.toggle('hidden')

  # Menu Navigation
  initMenuNavigation: ->
    menuMain = @getElement('menu-main')
    nimbusAgentSection = @getElement('nimbus-agent-section')
    settingsSection = @getElement('settings-section')
    threadsSection = @getElement('threads-section')
    menuDropdown = @getElement('menu-dropdown')
    return unless menuMain and nimbusAgentSection and settingsSection and threadsSection and menuDropdown

    document.querySelector('#nimbus-agent-btn').addEventListener 'click', (e) =>
      e.stopPropagation()
      menuMain.classList.add('hidden')
      nimbusAgentSection.classList.remove('hidden')
      menuDropdown.classList.remove('hidden')

    document.querySelector('#nimbus-agent-back').addEventListener 'click', (e) =>
      e.stopPropagation()
      menuMain.classList.remove('hidden')
      nimbusAgentSection.classList.add('hidden')
      menuDropdown.classList.remove('hidden')

    document.querySelector('#settings-btn').addEventListener 'click', (e) =>
      e.stopPropagation()
      menuMain.classList.add('hidden')
      settingsSection.classList.remove('hidden')
      menuDropdown.classList.remove('hidden')

    document.querySelector('#settings-back').addEventListener 'click', (e) =>
      e.stopPropagation()
      menuMain.classList.remove('hidden')
      settingsSection.classList.add('hidden')
      menuDropdown.classList.remove('hidden')

    document.querySelector('#threads-btn').addEventListener 'click', (e) =>
      e.stopPropagation()
      menuMain.classList.add('hidden')
      threadsSection.classList.remove('hidden')
      menuDropdown.classList.remove('hidden')

    document.querySelector('#threads-back').addEventListener 'click', (e) =>
      e.stopPropagation()
      menuMain.classList.remove('hidden')
      threadsSection.classList.add('hidden')
      menuDropdown.classList.remove('hidden')

  init: ->
    console.log '[NimbusPopup] Initializing...'
    chatIcon = @getElement('chat-icon')
    chatClose = @getElement('chat-close')
    chatInput = @getElement('chat-input')
    chatSend = @getElement('chat-send')
    menuToggle = @getElement('nimbusPopupMenu-toggle')
    thunderheadBtn = @getElement('thunderhead-btn')
    return unless chatIcon and chatClose and chatInput and chatSend and menuToggle and thunderheadBtn

    @initIconDragging()
    chatIcon.addEventListener 'click', => @openChatPopup()
    chatClose.addEventListener 'click', => @closeChatPopup()
    @initPopupDragging()
    chatInput.addEventListener 'input', => @updateWordCount()
    chatSend.addEventListener 'click', => @handleChatSubmission()
    thunderheadBtn.addEventListener 'click', => @handleThunderhead()
    menuToggle.addEventListener 'click', (e) => @toggleMenuDropdown(e)

    document.addEventListener 'click', (e) =>
      menuToggle = @getElement('nimbusPopupMenu-toggle')
      menuDropdown = @getElement('menu-dropdown')
      if menuToggle and menuDropdown and not menuToggle.contains(e.target) and not menuDropdown.contains(e.target)
        menuDropdown.classList.add('hidden')

    @initMenuNavigation()

# Ensure init runs even if DOMContentLoaded has already fired
if document.readyState is 'complete' or document.readyState is 'interactive'
  NimbusPopup.init()
else
  document.addEventListener 'DOMContentLoaded', ->
    NimbusPopup.init()

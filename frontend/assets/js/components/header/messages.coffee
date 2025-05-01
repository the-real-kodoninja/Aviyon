Messages =
  getElement: (id) ->
    try
      element = document.getElementById(id)
      throw new Error("Element with ID #{id} not found") unless element
      element
    catch e
      console.error '[Messages] Error:', e.message
      null

  toggleDropdown: (toggleId, dropdownId) ->
    toggle = @getElement(toggleId)
    dropdown = @getElement(dropdownId)
    return unless toggle and dropdown

    toggle.addEventListener 'click', (e) =>
      e.stopPropagation()
      dropdown.classList.toggle('hidden')

  init: ->
    @toggleDropdown 'aviyon-messages-toggle', 'aviyon-messages-dropdown'

    document.addEventListener 'click', (e) =>
      messagesDropdown = @getElement('aviyon-messages-dropdown')
      messagesToggle = @getElement('aviyon-messages-toggle')
      if messagesDropdown and messagesToggle and not messagesToggle.contains(e.target) and not messagesDropdown.contains(e.target)
        messagesDropdown.classList.add('hidden')

      target = e.target
      if target.closest('.aviyon-message-item')
        messagesList = @getElement('aviyon-messages-list')
        messageView = @getElement('aviyon-message-view')
        if messagesList and messageView
          messagesList.classList.add('hidden')
          messageView.classList.remove('hidden')

      if target.closest('#aviyon-message-back')
        messagesList = @getElement('aviyon-messages-list')
        messageView = @getElement('aviyon-message-view')
        if messagesList and messageView
          messagesList.classList.remove('hidden')
          messageView.classList.add('hidden')

      if target.closest('.aviyon-delete-message')
        e.stopPropagation()
        messageItem = target.closest('.aviyon-message-item')
        messageItem.remove()

document.addEventListener 'DOMContentLoaded', ->
  Messages.init()

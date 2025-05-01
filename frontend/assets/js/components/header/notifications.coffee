Notifications =
  getElement: (id) ->
    try
      element = document.getElementById(id)
      throw new Error("Element with ID #{id} not found") unless element
      element
    catch e
      console.error '[Notifications] Error:', e.message
      null

  toggleDropdown: (toggleId, dropdownId) ->
    toggle = @getElement(toggleId)
    dropdown = @getElement(dropdownId)
    return unless toggle and dropdown

    toggle.addEventListener 'click', (e) =>
      e.stopPropagation()
      dropdown.classList.toggle('hidden')

  init: ->
    @toggleDropdown 'aviyon-notifications-toggle', 'aviyon-notifications-dropdown'

    document.addEventListener 'click', (e) =>
      notificationsDropdown = @getElement('aviyon-notifications-dropdown')
      notificationsToggle = @getElement('aviyon-notifications-toggle')
      if notificationsDropdown and notificationsToggle and not notificationsToggle.contains(e.target) and not notificationsDropdown.contains(e.target)
        notificationsDropdown.classList.add('hidden')

      target = e.target
      if target.closest('.aviyon-notification-item')
        notificationsList = @getElement('aviyon-notifications-list')
        notificationView = @getElement('aviyon-notification-view')
        if notificationsList and notificationView
          notificationsList.classList.add('hidden')
          notificationView.classList.remove('hidden')

      if target.closest('#aviyon-notification-back')
        notificationsList = @getElement('aviyon-notifications-list')
        notificationView = @getElement('aviyon-notification-view')
        if notificationsList and notificationView
          notificationsList.classList.remove('hidden')
          notificationView.classList.add('hidden')

      if target.closest('.aviyon-delete-notification')
        e.stopPropagation()
        notificationItem = target.closest('.aviyon-notification-item')
        notificationItem.remove()

document.addEventListener 'DOMContentLoaded', ->
  Notifications.init()

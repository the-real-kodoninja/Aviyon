# Namespace for all Aviyon header functionality
AviyonHeader =
  # Utility to safely get elements
  getElement: (id) ->
    try
      element = document.getElementById(id)
      throw new Error("Element with ID #{id} not found") unless element
      element
    catch e
      console.error '[AviyonHeader] Error:', e.message
      null

  # Toggle dropdown visibility
  toggleDropdown: (toggleId, dropdownId) ->
    toggle = @getElement(toggleId)
    dropdown = @getElement(dropdownId)
    return unless toggle and dropdown

    toggle.addEventListener 'click', (e) ->
      e.stopPropagation()
      dropdown.classList.toggle('hidden')

  # Initialize all dropdowns and functionality
  init: ->
    header = @getElement('aviyon-header')
    return unless header

    # Dropdowns: Menu, Cart, Messages, Notifications, User
    dropdowns = [
      { toggle: 'aviyon-menu-toggle', dropdown: 'aviyon-menu-dropdown' }
      { toggle: 'aviyon-cart-toggle', dropdown: 'aviyon-cart-dropdown' }
      { toggle: 'aviyon-messages-toggle', dropdown: 'aviyon-messages-dropdown' }
      { toggle: 'aviyon-notifications-toggle', dropdown: 'aviyon-notifications-dropdown' }
      { toggle: 'aviyon-user-toggle', dropdown: 'aviyon-user-dropdown' }
    ]

    dropdowns.forEach ({ toggle, dropdown }) => @toggleDropdown(toggle, dropdown)

    # Wallet Collapsible
    walletToggle = @getElement('wallet-toggle')
    walletContent = @getElement('wallet-content')
    walletChevron = @getElement('wallet-chevron')
    if walletToggle and walletContent and walletChevron
      walletToggle.addEventListener 'click', =>
        walletContent.classList.toggle('hidden')
        walletChevron.classList.toggle('rotate-180')

    # Search Dropdown
    searchBar = @getElement('aviyon-search-bar')
    searchDropdown = @getElement('aviyon-search-dropdown')
    if searchBar and searchDropdown
      searchBar.addEventListener 'focus', => searchDropdown.classList.remove('hidden')
      searchBar.addEventListener 'blur', => setTimeout (=> searchDropdown.classList.add('hidden')), 100

    # Event Delegation for all header interactions
    header.addEventListener 'click', (e) =>
      e.stopPropagation()
      target = e.target

      # Close all dropdowns if clicking outside
      dropdowns.forEach ({ toggle, dropdown }) =>
        toggleEl = @getElement(toggle)
        dropdownEl = @getElement(dropdown)
        if dropdownEl and not (toggleEl?.contains(target) or dropdownEl.contains(target))
          dropdownEl.classList.add('hidden')

      # Cart Interactions
      if target.closest('.aviyon-quantity-increase')
        item = target.closest('.aviyon-cart-item')
        quantityEl = item.querySelector('.aviyon-quantity')
        priceEl = item.querySelector('.aviyon-price')
        basePrice = parseFloat(priceEl.textContent) / parseInt(quantityEl.textContent)
        count = parseInt(quantityEl.textContent) + 1
        quantityEl.textContent = count
        priceEl.textContent = "#{ (basePrice * count).toFixed(2) } AM"
        @updateCartTotal()

      if target.closest('.aviyon-quantity-decrease')
        item = target.closest('.aviyon-cart-item')
        quantityEl = item.querySelector('.aviyon-quantity')
        priceEl = item.querySelector('.aviyon-price')
        count = parseInt(quantityEl.textContent)
        if count > 1
          basePrice = parseFloat(priceEl.textContent) / count
          quantityEl.textContent = count - 1
          priceEl.textContent = "#{ (basePrice * (count - 1)).toFixed(2) } AM"
          @updateCartTotal()

      if target.closest('.aviyon-delete-item')
        item = target.closest('.aviyon-cart-item')
        item.remove()
        @updateCartTotal()
        cartCount = @getElement('aviyon-cart-count')
        cartCount.textContent = document.querySelectorAll('.aviyon-cart-item').length if cartCount

      # Messages Interactions
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
        target.closest('.aviyon-message-item').remove()

      # Notifications Interactions
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
        target.closest('.aviyon-notification-item').remove()

      # Ticker Controls
      if target.closest('#aviyon-toggle-ticker')
        ticker = @getElement('aviyon-ticker-container')
        ticker.classList.toggle('hidden') if ticker

      if target.closest('#aviyon-ticker-prefs')
        modal = @getElement('aviyon-ticker-prefs-modal')
        modal.classList.remove('hidden') if modal

      if target.closest('#aviyon-ticker-prefs-close')
        modal = @getElement('aviyon-ticker-prefs-modal')
        modal.classList.add('hidden') if modal

    # Theme Toggle
    themeToggle = @getElement('aviyon-theme-toggle')
    if themeToggle
      themeToggle.addEventListener 'change', (e) =>
        theme = e.target.value
        document.documentElement.classList.remove('dark', 'light', 'earth')
        document.documentElement.classList.add(theme)

  # Update Cart Total
  updateCartTotal: ->
    try
      prices = Array.from(document.querySelectorAll('.aviyon-price')).map (p) -> parseFloat(p.textContent) or 0
      total = prices.reduce ((sum, price) -> sum + price), 0
      cartTotal = @getElement('aviyon-cart-total')
      cartTotal.textContent = "#{total.toFixed(2)} AM" if cartTotal
    catch e
      console.error '[AviyonHeader] Error updating cart total:', e.message

# Initialize when DOM is ready
document.addEventListener 'DOMContentLoaded', ->
  AviyonHeader.init()

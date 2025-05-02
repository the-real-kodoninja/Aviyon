# assets/js/components/header/user.coffee

User =
  getElement: (id) ->
    try
      element = document.getElementById(id)
      throw new Error("Element with ID #{id} not found") unless element
      element
    catch e
      console.error '[User] Error:', e.message
      null

  toggleDropdown: (toggleId, dropdownId) ->
    toggle = @getElement(toggleId)
    dropdown = @getElement(dropdownId)
    return unless toggle and dropdown

    toggle.addEventListener 'click', (e) =>
      e.stopPropagation()
      dropdown.classList.toggle('hidden')

  init: ->
    @toggleDropdown 'aviyon-user-toggle', 'aviyon-user-dropdown'

    # Post Dropdown
    postToggle = @getElement('post-toggle')
    postContent = @getElement('post-content')
    postChevron = @getElement('post-chevron')
    if postToggle and postContent and postChevron
      postToggle.addEventListener 'click', =>
        postContent.classList.toggle('hidden')
        postChevron.classList.toggle('rotate-180')
    else
      console.warn '[User] Post dropdown elements missing'

    # Wallet Dropdown
    walletToggle = @getElement('wallet-toggle')
    walletContent = @getElement('wallet-content')
    walletChevron = @getElement('wallet-chevron')
    if walletToggle and walletContent and walletChevron
      walletToggle.addEventListener 'click', =>
        walletContent.classList.toggle('hidden')
        walletChevron.classList.toggle('rotate-180')

    # Platform Post Popup Trigger
    document.querySelector('[data-action="platform-post"]')?.addEventListener 'click', (e) =>
      e.preventDefault()
      PostPopup.open()

    document.addEventListener 'click', (e) =>
      userDropdown = @getElement('aviyon-user-dropdown')
      userToggle = @getElement('aviyon-user-toggle')
      if userDropdown and userToggle and not userToggle.contains(e.target) and not userDropdown.contains(e.target)
        userDropdown.classList.add('hidden')

document.addEventListener 'DOMContentLoaded', ->
  User.init()

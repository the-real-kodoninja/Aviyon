Newsletter =
  getElement: (id) ->
    try
      element = document.getElementById(id)
      throw new Error("Element with ID #{id} not found") unless element
      element
    catch e
      console.error '[Newsletter] Error:', e.message
      null

  # Validate email format
  validateEmail: (email) ->
    regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    regex.test(email)

  # Simulate backend response (since backend isn't set up)
  simulateBackendResponse: (email) ->
    # Randomly select one of the four outcomes
    outcomes = [
      { type: 'error', message: 'Oops! Something broke—our servers are having a bad day. Try again later!' }
      { type: 'success', message: "Success! A confirmation email has been sent to #{email}. Just click 'Confirm' to join the Aviyon Newsletter—expect weekly updates packed with trading tips, crypto insights, and Web3 trends!" }
      { type: 'already_subscribed', message: 'Hey, looks like you’re already on the list! Keep an eye on your inbox for the latest Aviyon updates.' }
      { type: 'unconfirmed', message: "Looks like you signed up with #{email} but haven’t confirmed yet. No worries—we’ve sent another confirmation email. Just click 'Confirm' to join the fun!" }
    ]
    outcomes[Math.floor(Math.random() * outcomes.length)]

  # Handle form submission
  handleSubscription: (e) ->
    e.preventDefault()
    form = e.target
    emailInput = form.querySelector('input[name="email"]')
    email = emailInput.value.trim()
    responseDiv = @getElement('newsletter-response')

    return unless emailInput and responseDiv

    # Clear previous response
    responseDiv.textContent = ''
    responseDiv.className = 'mt-2 text-sm'

    # Validate email
    unless @validateEmail(email)
      responseDiv.textContent = 'Please enter a valid email address.'
      responseDiv.classList.add('text-red-400')
      return

    # Simulate backend response
    response = @simulateBackendResponse(email)

    # Display the response with appropriate styling
    responseDiv.textContent = response.message
    switch response.type
      when 'error'
        responseDiv.classList.add('text-red-400')
      when 'success'
        responseDiv.classList.add('text-green-400')
      when 'already_subscribed', 'unconfirmed'
        responseDiv.classList.add('text-yellow-400')

    # Clear the input
    emailInput.value = ''

  init: ->
    console.log '[Newsletter] Initializing...'
    form = document.querySelector('form[action="{{ path(\'newsletter_subscribe\') }}"]')
    return unless form

    # Ensure the response div exists
    responseDiv = @getElement('newsletter-response')
    unless responseDiv
      responseDiv = document.createElement('div')
      responseDiv.id = 'newsletter-response'
      responseDiv.className = 'mt-2 text-sm'
      form.appendChild(responseDiv)

    form.addEventListener 'submit', (e) => @handleSubscription(e)

# Ensure init runs even if DOMContentLoaded has already fired
if document.readyState is 'complete' or document.readyState is 'interactive'
  Newsletter.init()
else
  document.addEventListener 'DOMContentLoaded', ->
    Newsletter.init()

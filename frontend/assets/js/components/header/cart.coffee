Cart =
  getElement: (id) ->
    try
      element = document.getElementById(id)
      throw new Error("Element with ID #{id} not found") unless element
      element
    catch e
      console.error '[Cart] Error:', e.message
      null

  toggleDropdown: (toggleId, dropdownId) ->
    toggle = @getElement(toggleId)
    dropdown = @getElement(dropdownId)
    return unless toggle and dropdown

    toggle.addEventListener 'click', (e) =>
      e.stopPropagation()
      dropdown.classList.toggle('hidden')

  updateCartTotal: ->
    try
      prices = Array.from(document.querySelectorAll('.aviyon-price')).map (p) -> parseFloat(p.textContent) or 0
      total = prices.reduce ((sum, price) -> sum + price), 0
      cartTotal = @getElement('aviyon-cart-total')
      cartTotal.textContent = "#{total.toFixed(2)} AM" if cartTotal
    catch e
      console.error '[Cart] Error updating cart total:', e.message

  init: ->
    @toggleDropdown 'aviyon-cart-toggle', 'aviyon-cart-dropdown'

    document.addEventListener 'click', (e) =>
      cartDropdown = @getElement('aviyon-cart-dropdown')
      cartToggle = @getElement('aviyon-cart-toggle')
      if cartDropdown and cartToggle and not cartToggle.contains(e.target) and not cartDropdown.contains(e.target)
        cartDropdown.classList.add('hidden')

      target = e.target

      if target.closest('.aviyon-quantity-increase')
        item = target.closest('.aviyon-cart-item')
        quantityEl = item.querySelector('.aviyon-quantity')
        priceEl = item.querySelector('.aviyon-price')
        basePrice = parseFloat(priceEl.textContent) / parseInt(quantityEl.textContent)
        count = parseInt(quantityEl.textContent) + 1
        quantityEl.textContent = count
        priceEl.textContent = "#{(basePrice * count).toFixed(2)} AM"
        @updateCartTotal()

      if target.closest('.aviyon-quantity-decrease')
        item = target.closest('.aviyon-cart-item')
        quantityEl = item.querySelector('.aviyon-quantity')
        priceEl = item.querySelector('.aviyon-price')
        count = parseInt(quantityEl.textContent)
        if count > 1
          basePrice = parseFloat(priceEl.textContent) / count
          quantityEl.textContent = count - 1
          priceEl.textContent = "#{(basePrice * (count - 1)).toFixed(2)} AM"
          @updateCartTotal()

      if target.closest('.aviyon-delete-item')
        item = target.closest('.aviyon-cart-item')
        item.remove()
        @updateCartTotal()
        cartCount = @getElement('aviyon-cart-count')
        cartCount.textContent = document.querySelectorAll('.aviyon-cart-item').length if cartCount

document.addEventListener 'DOMContentLoaded', ->
  Cart.init()

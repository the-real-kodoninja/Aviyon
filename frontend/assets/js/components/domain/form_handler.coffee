init = ->
     console.log 'Domain form handler initialized'
     form = document.getElementById 'domain-form'
     return unless form

     subdomainInput = form.querySelector 'input[name="subdomain"]'
     domainExtension = form.querySelector 'select[name="domain_extension"]'
     availabilityDiv = document.getElementById 'domain-availability'

     checkAvailability = ->
       subdomain = subdomainInput.value.trim()
       extension = domainExtension.value
       return unless subdomain.length >= 3

       fetch "/domain/check-availability?subdomain=#{subdomain}#{extension}",
         method: 'GET'
         headers:
           'Content-Type': 'application/json'
       .then (response) -> response.json()
       .then (data) ->
         availabilityDiv.classList.remove 'hidden'
         if data.available
           availabilityDiv.textContent = 'Domain is available!'
           availabilityDiv.classList.remove 'text-red-400'
           availabilityDiv.classList.add 'text-green-400'
         else
           availabilityDiv.textContent = 'Domain is taken. Try another.'
           availabilityDiv.classList.remove 'text-green-400'
           availabilityDiv.classList.add 'text-red-400'
       .catch (error) ->
         console.error 'Error checking availability:', error
         availabilityDiv.textContent = 'Error checking availability.'
         availabilityDiv.classList.add 'text-red-400'

     subdomainInput.addEventListener 'input', ->
       subdomain = subdomainInput.value.trim()
       subdomainRegex = /^[a-zA-Z0-9-]{3,}$/
       unless subdomainRegex.test subdomain
         availabilityDiv.classList.remove 'hidden'
         availabilityDiv.textContent = 'Subdomain must be at least 3 characters and contain only letters, numbers, or hyphens.'
         availabilityDiv.classList.add 'text-red-400'
       else
         checkAvailability()

     domainExtension.addEventListener 'change', checkAvailability

     form.addEventListener 'submit', (e) ->
       subdomain = subdomainInput.value.trim()
       subdomainRegex = /^[a-zA-Z0-9-]{3,}$/
       unless subdomainRegex.test subdomain
         e.preventDefault()
         alert 'Subdomain must be at least 3 characters long and can only contain letters, numbers, and hyphens.'

   module.exports = { init }

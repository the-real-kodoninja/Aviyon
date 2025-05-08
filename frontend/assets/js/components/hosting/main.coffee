document.addEventListener 'DOMContentLoaded', ->
     console.log 'Hosting dashboard initialized'
     form = document.querySelector 'form[action="/dashboard/hosting/quick-deploy"]'
     return unless form

     form.addEventListener 'submit', (e) ->
       projectName = form.querySelector('#project_name').value.trim()
       unless projectName
         e.preventDefault()
         alert 'Please enter a project name.'

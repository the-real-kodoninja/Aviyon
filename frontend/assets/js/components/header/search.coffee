Search =
  getElement: (id) ->
    try
      element = document.getElementById(id)
      throw new Error("Element with ID #{id} not found") unless element
      element
    catch e
      console.error '[Search] Error:', e.message
      null

  init: ->
    searchBar = @getElement('aviyon-search-bar')
    searchDropdown = @getElement('aviyon-search-dropdown')
    if searchBar and searchDropdown
      searchBar.addEventListener 'focus', =>
        searchDropdown.classList.remove('hidden')
      searchBar.addEventListener 'blur', =>
        setTimeout =>
          searchDropdown.classList.add('hidden')
        , 100

      document.addEventListener 'click', (e) =>
        if not searchBar.contains(e.target) and not searchDropdown.contains(e.target)
          searchDropdown.classList.add('hidden')

document.addEventListener 'DOMContentLoaded', ->
  Search.init()

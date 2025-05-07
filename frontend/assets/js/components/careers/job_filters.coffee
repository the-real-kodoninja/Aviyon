document.addEventListener 'DOMContentLoaded', ->
  # Elements
  searchJobs = document.getElementById('search-jobs')
  filterDepartment = document.getElementById('filter-department')
  filterLocation = document.getElementById('filter-location')
  jobListings = document.getElementById('job-listings')
  jobCategories = jobListings.querySelectorAll('.job-category')
  jobCards = jobListings.querySelectorAll('.job-card')

  # Filter and Search Jobs
  filterJobs = ->
    searchTerm = searchJobs.value.toLowerCase()
    selectedDepartment = filterDepartment.value
    selectedLocation = filterLocation.value

    jobCategories.forEach (category) ->
      category.style.display = 'none'
      category.querySelectorAll('.job-card').forEach (card) ->
        card.style.display = 'none'

    matchesFound = false
    jobCards.forEach (card) ->
      title = card.querySelector('h4').textContent.toLowerCase()
      departmentMatch = selectedDepartment is '' or card.parentElement.parentElement.dataset.department is selectedDepartment
      locationMatch = selectedLocation is '' or card.dataset.location is selectedLocation
      searchMatch = searchTerm is '' or title.includes(searchTerm)

      if departmentMatch and locationMatch and searchMatch
        card.style.display = 'block'
        card.parentElement.parentElement.style.display = 'block'
        matchesFound = true

    if not matchesFound
      jobListings.innerHTML = '<p class="text-gray-400 text-center text-xl">No matching positions found. Try adjusting your search or filters.</p>'

  # Event Listeners for Filters and Search
  searchJobs.addEventListener 'input', filterJobs
  filterDepartment.addEventListener 'change', filterJobs
  filterLocation.addEventListener 'change', filterJobs

  # Initial Filter
  filterJobs()

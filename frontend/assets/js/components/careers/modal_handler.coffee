document.addEventListener 'DOMContentLoaded', ->
  # Elements
  applicationModal = document.getElementById('application-modal')
  modalContent = document.getElementById('modal-content')
  closeModalBtn = document.getElementById('close-modal')

  # Modal Handling with AI Match Score
  openModal = (url) ->
    fetch(url)
      .then((response) -> response.text())
      .then((html) ->
        modalContent.innerHTML = html
        applicationModal.classList.remove('hidden')
        # Mock AI match score calculation
        setTimeout(->
          matchScore = Math.floor(Math.random() * (95 - 75 + 1)) + 75 # Random score between 75-95%
          modalContent.querySelector('#ai-match-score')?.textContent = "#{matchScore}%"
        , 1000)
      )
      .catch((error) -> console.error('Error loading job details:', error))

  closeModalBtn.addEventListener 'click', ->
    applicationModal.classList.add('hidden')
    modalContent.innerHTML = ''

  window.openModal = openModal

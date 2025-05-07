init = ->
  exploreBtn = document.getElementById 'lore-explore'
  storyDiv = document.getElementById 'lore-story'
  exploreBtn.addEventListener 'click', ->
    storyDiv.classList.toggle 'hidden'

module.exports = { init }

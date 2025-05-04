$ ->
  # Tab Switching
  $('.tab-btn').on 'click', (e) ->
    tab = $(this).data('tab')
    $('.tab-btn').removeClass('text-purple-400 border-purple-400')
    $(this).addClass('text-purple-400 border-purple-400')
    $('#projects, #activity, #nfts, #feed').addClass('hidden')
    $("##{tab}").removeClass('hidden')

  # Initial Tab
  $('.tab-btn[data-tab="projects"]').click()

  # Interaction Handlers
  $('#follow-user').on 'click', ->
    alert "You have pledged allegiance to #{gon.user.username}! Their Aether Rank ascends."
  $('#gift-mark').on 'click', ->
    alert "You have gifted an Aether Mark to #{gon.user.username}! Their legacy grows."
  $('.trade-nft').on 'click', (e) ->
    nftId = $(this).data('nftId')
    nftName = $(this).closest('.bg-gray-800').find('h3').text()
    alert "Trade initiated for #{nftName}. Visit the Marketplace to complete."

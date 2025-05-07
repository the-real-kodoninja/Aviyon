init = ->
  # Feed Filter
  feedFilter = document.getElementById 'investing-filter'
  feed = document.getElementById 'company-feed'
  feedFilter.addEventListener 'input', ->
    filter = feedFilter.value.toLowerCase()
    posts = feed.querySelectorAll '.post'
    posts.forEach (post) ->
      text = post.textContent.toLowerCase()
      post.style.display = if text.includes(filter) then '' else 'none'

  # Load More Feed
  loadMoreFeed = document.getElementById 'load-more-feed'
  loadMoreFeed.addEventListener 'click', ->
    page = parseInt(loadMoreFeed.dataset.page) + 1
    fetch "/investing/feed?page=#{page}"
      .then (response) -> response.json()
      .then (data) ->
        data.posts.forEach (post) ->
          postDiv = document.createElement 'div'
          postDiv.className = 'post bg-dark p-4 rounded-lg'
          postDiv.innerHTML = """
            <p class="text-gray-300"><strong>Board Member:</strong> #{post.content}</p>
            <p class="text-gray-400 text-sm">#{post.timestamp}</p>
            <button class="like-btn text-gray-300 hover:text-neon-purple transition mt-2" data-post-id="#{post.id}"><span>#{post.likes}</span> Likes</button>
            <button class="comment-toggle text-gray-300 hover:text-neon-purple transition ml-4">Comment</button>
            <form class="comment-form hidden mt-2" action="/investing/add-comment" method="POST">
                <input type="hidden" name="post_id" value="#{post.id}">
                <textarea name="comment" placeholder="Add a comment..." class="w-full p-2 bg-dark-light rounded-lg text-gray-300 focus:outline-none focus:ring-2 focus:ring-neon-purple"></textarea>
                <button type="submit" class="mt-2 bg-neon-purple text-white px-4 py-2 rounded-lg hover:bg-neon-purple/80 transition">Submit</button>
            </form>
          """
          feed.appendChild postDiv
        loadMoreFeed.dataset.page = page
      .catch (error) -> console.error 'Error loading feed:', error

  # Like and Comment Interactions
  document.addEventListener 'click', (e) ->
    if e.target.classList.contains 'like-btn'
      postId = e.target.dataset.postId
      likeCount = parseInt(e.target.querySelector('span').textContent) + 1
      e.target.querySelector('span').textContent = likeCount

    if e.target.classList.contains 'comment-toggle'
      form = e.target.nextElementSibling
      form.classList.toggle 'hidden'

module.exports = { init }

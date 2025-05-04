document.addEventListener 'DOMContentLoaded', ->
  tabButtons = document.querySelectorAll '.tab-btn'
  sidebar = document.getElementById 'sidebar'

  updateSidebar = (tab) ->
    sidebar.innerHTML = switch tab
      when 'post'
        """
        <div class="bg-gray-800 p-6 rounded-lg shadow-lg">
          <h3 class="text-lg text-purple-400 mb-4">Trending Topics</h3>
          <ul class="text-gray-300 space-y-2">
            <li><a href="/search?q=%23AviyonOS" class="hover:text-purple-400">#AviyonOS</a></li>
            <li><a href="/search?q=%23CloudMining" class="hover:text-purple-400">#CloudMining</a></li>
            <li><a href="/search?q=%23NFTs" class="hover:text-purple-400">#NFTs</a></li>
          </ul>
        </div>
        """
      when 'replies'
        """
        <div class="bg-gray-800 p-6 rounded-lg shadow-lg">
          <h3 class="text-lg text-purple-400 mb-4">Recent Replies</h3>
          <ul class="text-gray-300 space-y-2">
            <li><a href="/user/alice" class="hover:text-purple-400">Alice on ASI</a></li>
            <li><a href="/user/bob" class="hover:text-purple-400">Bob on Cloud</a></li>
          </ul>
        </div>
        """
      when 'photos'
        """
        <div class="bg-gray-800 p-6 rounded-lg shadow-lg">
          <h3 class="text-lg text-purple-400 mb-4">Photo Highlights</h3>
          <div class="grid grid-cols-2 gap-2">
            <img src="{{ asset('build/images/sample1.jpg') }}" class="rounded">
            <img src="{{ asset('build/images/sample2.jpg') }}" class="rounded">
          </div>
        </div>
        """
      when 'videos'
        """
        <div class="bg-gray-800 p-6 rounded-lg shadow-lg">
          <h3 class="text-lg text-purple-400 mb-4">Video Picks</h3>
          <ul class="text-gray-300 space-y-2">
            <li><a href="/video/1" class="hover:text-purple-400">Demo Video 1</a></li>
            <li><a href="/video/2" class="hover:text-purple-400">Tutorial 2</a></li>
          </ul>
        </div>
        """
      when 'likes'
        """
        <div class="bg-gray-800 p-6 rounded-lg shadow-lg">
          <h3 class="text-lg text-purple-400 mb-4">Liked Communities</h3>
          <ul class="text-gray-300 space-y-2">
            <li><a href="/community/ai" class="hover:text-purple-400">AI Enthusiasts</a></li>
            <li><a href="/community/dev" class="hover:text-purple-400">Developers</a></li>
          </ul>
        </div>
        """
      when 'list'
        """
        <div class="bg-gray-800 p-6 rounded-lg shadow-lg">
          <h3 class="text-lg text-purple-400 mb-4">Custom Lists</h3>
          <ul class="text-gray-300 space-y-2">
            <li><a href="/list/innovators" class="hover:text-purple-400">Innovators</a></li>
            <li><a href="/list/creators" class="hover:text-purple-400">Creators</a></li>
          </ul>
        </div>
        """
      when 'saves'
        """
        <div class="bg-gray-800 p-6 rounded-lg shadow-lg">
          <h3 class="text-lg text-purple-400 mb-4">Saved Insights</h3>
          <ul class="text-gray-300 space-y-2">
            <li><a href="/save/1" class="hover:text-purple-400">ASI Article</a></li>
            <li><a href="/save/2" class="hover:text-purple-400">Coding Tip</a></li>
          </ul>
        </div>
        """
      else ''
    return

  for button in tabButtons
    button.addEventListener 'click', (e) ->
      tab = e.target.getAttribute 'data-tab'
      updateSidebar tab
  updateSidebar 'post' # Initial sidebar

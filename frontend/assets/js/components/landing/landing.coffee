# assets/js/components/landing/landing.coffee

# Simulate Chart.js for the tech sector trend graph (Neutral Report)
$ ->
  ctx = document.getElementById('tech-sector-trend').getContext('2d')
  new Chart ctx,
    type: 'line'
    data:
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May']
      datasets: [
        {
          label: 'Tech Sector Index'
          data: [1200, 1250, 1300, 1280, 1350]
          borderColor: '#8b5cf6'
          fill: false
        }
      ]
    options:
      responsive: true
      scales:
        y:
          beginAtZero: false

  # Load More functionality for Global Feed (Landing)
  $('#load-more-feed-landing').on 'click', ->
    # Simulate loading new posts
    newPost = '''
      <div class="bg-[var(--dark-bg)] p-6 rounded-lg shadow-lg hover:shadow-xl transition">
        <div class="flex items-center mb-4">
          <img src="/build/images/users/bob.jpg" alt="User Photo" class="w-8 h-8 rounded-full mr-2">
          <div>
            <p class="text-sm text-[var(--purple-accent)]">Bob</p>
            <p class="text-xs text-gray-400">Just now</p>
          </div>
        </div>
        <p class="text-gray-300 mb-4">Just minted my first NFT on Kodoverse! So excited! 🎉 #NFTMarket</p>
        <div class="flex justify-between items-center">
          <div class="flex space-x-4">
            <div class="flex items-center text-gray-400 post-interaction">
              <svg class="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
              </svg>
              <span>10</span>
            </div>
            <div class="flex items-center text-gray-400 post-interaction">
              <svg class="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 24 24">
                <path d="M18 16.08c-.76 0-1.44.3-1.96.77L8.91 12.7c.05-.23.09-.46.09-.7s-.04-.47-.09-.70l7.05-4.11c.54.5 1.25.81 2.04.81 1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3c0 .24.04.47.09.70L8.04 9.81C7.5 9.31 6.79 9 6 9c-1.66 0-3 1.34-3 3s1.34 3 3 3c.79 0 1.5-.31 2.04-.81l7.12 4.16c-.05.21-.08.43-.08.65 0 1.61 1.31 2.92 2.92 2.92s2.92-1.31 2.92-2.92c0-1.61-1.31-2.92-2.92-2.92zM18 4c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zM6 13c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1zm12 7.02c-.55 0-1-.45-1-1s.45-1 1-1 1 .45 1 1-.45 1-1 1z"/>
              </svg>
              <span>5</span>
            </div>
          </div>
          <a href="/post/4" class="text-gray-400 post-interaction">Comment</a>
        </div>
      </div>
    '''
    $('#global-feed-landing').append(newPost)

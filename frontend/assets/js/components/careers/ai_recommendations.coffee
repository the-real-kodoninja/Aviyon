document.addEventListener 'DOMContentLoaded', ->
  # Elements
  aiRecommendations = document.getElementById('ai-recommendations')

  # AI-Driven Recommendations (Mock API Call)
  fetchAIRecommendations = ->
    # Mock API response from nimbus.ai
    mockResponse = [
      { id: 1, title: 'CEO, KodoFilms Studios', company: 'KodoFilms Studios', description: 'Lead 20+ production companies...', matchScore: 92 },
      { id: 3, title: 'Senior AI Engineer, nimbus.ai', company: 'nimbus.ai', description: 'Develop ASI/AGI models...', matchScore: 88 },
      { id: 6, title: 'Social Media Manager, Kodoverse', company: 'Kodoverse', description: 'Boost kodoanime.social presence...', matchScore: 85 }
    ]
    aiRecommendations.innerHTML = ''
    mockResponse.forEach (job) ->
      card = """
        <div class="bg-gray-900 p-6 rounded-xl shadow-lg hover:shadow-xl transition">
          <h4 class="text-xl font-semibold text-white">#{job.title}</h4>
          <p class="text-gray-300 mt-2">#{job.description}</p>
          <p class="text-gray-300 mt-2"><strong>Match Score:</strong> #{job.matchScore}%</p>
          <button class="mt-4 bg-neon-purple text-white px-4 py-2 rounded-lg hover:bg-purple-700 transition" onclick="openModal('/careers/job/#{job.id}')">Apply Now</button>
        </div>
      """
      aiRecommendations.innerHTML += card

  # Initial Setup
  fetchAIRecommendations()

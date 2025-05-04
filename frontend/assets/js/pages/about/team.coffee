# Team Member Click Handler
teamMembers = document.querySelectorAll '.team-member'
for member in teamMembers
  member.addEventListener 'click', (e) ->
    memberId = member.getAttribute 'data-member'
    content = switch memberId
      when 'sahar-hassounat'
        """
        <div class="text-center">
          <img src="{{ asset('build/images/sahar-hassounat.jpg') }}" alt="Sahar Hassounat" class="w-40 h-40 rounded-full mx-auto mb-4 border-4 border-purple-400">
          <h3 class="text-3xl text-purple-400 mb-2">Sahar Hassounat</h3>
          <p class="text-gray-300 font-semibold">Chief Executive Officer</p>
          <p class="text-gray-300 mt-4">PhD in AI from MIT, Sahar has 15+ years leading tech revolutions, including AGI breakthroughs at xAI. Passionate about merging human and machine intelligence.</p>
          <p class="text-gray-400 mt-2">Hobbies: Quantum computing research, cyberpunk literature.</p>
          <a href="{{ path('user_profile', {'username': 'sahar-hassounat'}) }}" class="mt-6 inline-block bg-cyan-600 text-white px-6 py-3 rounded-full hover:bg-cyan-700">Visit Profile</a>
          <a href="mailto:sahar@aviyon.com" class="mt-4 inline-block bg-purple-600 text-white px-6 py-3 rounded-full hover:bg-purple-700">Send Message</a>
        </div>
        """
      when 'emmanuel-moore'
        """
        <div class="text-center">
          <img src="{{ asset('build/images/emmanuel-moore.jpg') }}" alt="Emmanuel Moore" class="w-40 h-40 rounded-full mx-auto mb-4 border-4 border-cyan-400">
          <h3 class="text-3xl text-cyan-400 mb-2">Emmanuel Moore</h3>
          <p class="text-gray-300 font-semibold">Founder & Chief Technology Officer</p>
          <p class="text-gray-300 mt-4">A self-taught coding maestro, Emmanuel built the Kodoverse from scratch, with a portfolio of 50+ patented tech innovations.</p>
          <p class="text-gray-400 mt-2">Hobbies: 3D modeling, chess grandmaster.</p>
          <a href="{{ path('user_profile', {'username': 'emmanuel-moore'}) }}" class="mt-6 inline-block bg-cyan-600 text-white px-6 py-3 rounded-full hover:bg-cyan-700">Visit Profile</a>
          <a href="mailto:emmanuel@aviyon.com" class="mt-4 inline-block bg-purple-600 text-white px-6 py-3 rounded-full hover:bg-purple-700">Send Message</a>
        </div>
        """
      when 'alexandra-kim'
        """
        <div class="text-center">
          <img src="{{ asset('build/images/alexandra-kim.jpg') }}" alt="Alexandra Kim" class="w-40 h-40 rounded-full mx-auto mb-4 border-4 border-purple-400">
          <h3 class="text-3xl text-purple-400 mb-2">Alexandra Kim</h3>
          <p class="text-gray-300 font-semibold">Chief Innovation Officer</p>
          <p class="text-gray-300 mt-4">Stanford’s blockchain prodigy, Alexandra led the Web3-5 revolution, authoring 20+ whitepapers on decentralized tech.</p>
          <p class="text-gray-400 mt-2">Hobbies: Crypto art, mountain climbing.</p>
          <a href="{{ path('user_profile', {'username': 'alexandra-kim'}) }}" class="mt-6 inline-block bg-cyan-600 text-white px-6 py-3 rounded-full hover:bg-cyan-700">Visit Profile</a>
          <a href="mailto:alexandra@aviyon.com" class="mt-4 inline-block bg-purple-600 text-white px-6 py-3 rounded-full hover:bg-purple-700">Send Message</a>
        </div>
        """
      when 'rajesh-patel'
        """
        <div class="text-center">
          <img src="{{ asset('build/images/rajesh-patel.jpg') }}" alt="Rajesh Patel" class="w-40 h-40 rounded-full mx-auto mb-4 border-4 border-cyan-400">
          <h3 class="text-3xl text-cyan-400 mb-2">Rajesh Patel</h3>
          <p class="text-gray-300 font-semibold">Chief Financial Officer</p>
          <p class="text-gray-300 mt-4">Harvard MBA and DeFi strategist, Rajesh has managed $10B+ portfolios, ensuring Aviyon’s financial dominance.</p>
          <p class="text-gray-400 mt-2">Hobbies: Golf, economic forecasting.</p>
          <a href="{{ path('user_profile', {'username': 'rajesh-patel'}) }}" class="mt-6 inline-block bg-cyan-600 text-white px-6 py-3 rounded-full hover:bg-cyan-700">Visit Profile</a>
          <a href="mailto:rajesh@aviyon.com" class="mt-4 inline-block bg-purple-600 text-white px-6 py-3 rounded-full hover:bg-purple-700">Send Message</a>
        </div>
        """
      when 'lila-chan'
        """
        <div class="text-center">
          <img src="{{ asset('build/images/lila-chan.jpg') }}" alt="Lila Chan" class="w-40 h-40 rounded-full mx-auto mb-4 border-4 border-purple-400">
          <h3 class="text-3xl text-purple-400 mb-2">Lila Chan</h3>
          <p class="text-gray-300 font-semibold">Chief Marketing Officer</p>
          <p class="text-gray-300 mt-4">Tokyo’s marketing icon, Lila has crafted campaigns for tech giants, elevating Aviyon’s global brand.</p>
          <p class="text-gray-400 mt-2">Hobbies: Calligraphy, VR design.</p>
          <a href="{{ path('user_profile', {'username': 'lila-chan'}) }}" class="mt-6 inline-block bg-cyan-600 text-white px-6 py-3 rounded-full hover:bg-cyan-700">Visit Profile</a>
          <a href="mailto:lila@aviyon.com" class="mt-4 inline-block bg-purple-600 text-white px-6 py-3 rounded-full hover:bg-purple-700">Send Message</a>
        </div>
        """
      else
        ''
    document.querySelector('#profile-card-content').innerHTML = content
    document.querySelector('#profile-card-modal').classList.remove 'hidden'

# Close Modal
document.querySelector('#close-modal').addEventListener 'click', ->
  document.querySelector('#profile-card-modal').classList.add 'hidden'

# Prevent modal close on click inside content
document.querySelector('#profile-card-modal').addEventListener 'click', (e) ->
  if e.target.id is 'profile-card-modal'
    e.target.classList.add 'hidden'

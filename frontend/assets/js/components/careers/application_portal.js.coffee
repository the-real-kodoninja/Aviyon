document.addEventListener 'DOMContentLoaded', ->
  applicationPortal = document.getElementById('application-portal')
  closePortalBtn = document.getElementById('close-portal')
  portalContent = document.getElementById('portal-content')
  applyNowBtn = document.getElementById('apply-now')

  applyNowBtn.addEventListener 'click', ->
    applicationPortal.classList.remove('hidden')
    portalContent.innerHTML = '<h3 class="text-2xl text-neon-purple">Select a Position or Browse All</h3><div id="application-form"></div>'
    loadApplicationForm(null)

  closePortalBtn.addEventListener 'click', ->
    applicationPortal.classList.add('hidden')

  window.loadApplicationForm = (jobId) ->
    fetch(if jobId then "/careers/job/#{jobId}" else "/careers")
      .then((response) -> response.json())
      .then((data) ->
        formHtml = '''
          <form id="apply-form" class="space-y-6">
            <div><label class="block text-gray-300">Full Name</label><input type="text" name="name" class="w-full p-3 bg-gray-700 rounded-lg text-gray-200 focus:ring-2 focus:ring-neon-purple" required></div>
            <div><label class="block text-gray-300">Email</label><input type="email" name="email" class="w-full p-3 bg-gray-700 rounded-lg text-gray-200 focus:ring-2 focus:ring-neon-purple" required></div>
            <div><label class="block text-gray-300">Position</label><select name="position" class="w-full p-3 bg-gray-700 rounded-lg text-gray-200 focus:ring-2 focus:ring-neon-purple" required><option value="">Select a Position</option>#{if jobId then "<option value=\"#{jobId}\">#{data.title} at #{data.company}</option>" else Object.values(data.jobs).map((j) -> "<option value=\"#{j.id}\">#{j.title} at #{j.company}</option>").join('')}</select></div>
            <div><label class="block text-gray-300">Resume</label><textarea name="resume" class="w-full p-3 bg-gray-700 rounded-lg text-gray-200 focus:ring-2 focus:ring-neon-purple h-32" placeholder="Paste URL or text" required></textarea></div>
            <div><label class="block text-gray-300">Video Intro (URL)</label><input type="url" name="video" class="w-full p-3 bg-gray-700 rounded-lg text-gray-200 focus:ring-2 focus:ring-neon-purple"></div>
            <div><label class="block text-gray-300">Portfolio (URL)</label><input type="url" name="portfolio" class="w-full p-3 bg-gray-700 rounded-lg text-gray-200 focus:ring-2 focus:ring-neon-purple"></div>
            <div><label class="block text-gray-300">Skills Assessment</label><textarea name="assessment" class="w-full p-3 bg-gray-700 rounded-lg text-gray-200 focus:ring-2 focus:ring-neon-purple h-24" placeholder="Describe your skills"></textarea></div>
            <button type="submit" class="bg-neon-purple text-white px-6 py-3 rounded-lg hover:bg-purple-700 transition">Submit</button>
          </form>
          <div id="ai-feedback" class="mt-4 text-gray-300 hidden"></div>
        '''
        portalContent.querySelector('#application-form').innerHTML = formHtml
        document.getElementById('apply-form').addEventListener 'submit', (e) ->
          e.preventDefault()
          formData = new FormData(e.target)
          fetch('/careers/apply', { method: 'POST', body: formData })
            .then((response) -> response.json())
            .then((data) ->
              document.getElementById('ai-feedback').classList.remove('hidden')
              document.getElementById('ai-feedback').textContent = data.message || 'Application submitted! AI review in progress.'
            )
      )

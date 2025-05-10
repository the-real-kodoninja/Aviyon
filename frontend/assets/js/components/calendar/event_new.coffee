# assets/js/components/calendar/event_new.coffee

# Character Count
document.getElementById('event-description').addEventListener 'input', ->
  charCount = @value.length
  document.getElementById('event-char-count').textContent = "#{charCount} characters"

# Recurring Event Toggle
document.getElementById('event-recurring').addEventListener 'change', ->
  recurringOptions = document.getElementById('recurring-options')
  if @checked
    recurringOptions.classList.remove('hidden')
  else
    recurringOptions.classList.add('hidden')

# Reminder Toggle
document.getElementById('event-reminder').addEventListener 'change', ->
  reminderOptions = document.getElementById('reminder-options')
  if @checked
    reminderOptions.classList.remove('hidden')
  else
    reminderOptions.classList.add('hidden')

# Media Upload
document.getElementById('add-image-event').addEventListener 'click', ->
  input = document.createElement('input')
  input.type = 'file'
  input.accept = 'image/*'
  input.addEventListener 'change', (e) ->
    file = e.target.files[0]
    if file
      reader = new FileReader()
      reader.onload = (event) ->
        img = document.createElement('img')
        img.src = event.target.result
        img.className = 'w-full h-60 object-cover rounded-lg mt-4'
        document.getElementById('event-description').parentNode.insertBefore(img, document.getElementById('event-description').nextSibling)
      reader.readAsDataURL(file)
  input.click()

document.getElementById('add-video-event').addEventListener 'click', ->
  input = document.createElement('input')
  input.type = 'file'
  input.accept = 'video/*'
  input.addEventListener 'change', (e) ->
    file = e.target.files[0]
    if file
      reader = new FileReader()
      reader.onload = (event) ->
        video = document.createElement('video')
        video.controls = true
        video.className = 'w-full h-60 object-cover rounded-lg mt-4'
        source = document.createElement('source')
        source.src = event.target.result
        source.type = 'video/mp4'
        video.appendChild(source)
        document.getElementById('event-description').parentNode.insertBefore(video, document.getElementById('event-description').nextSibling)
      reader.readAsDataURL(file)
  input.click()

# AI Suggest (placeholder)
document.getElementById('ai-suggest-event').addEventListener 'click', ->
  alert('AI suggestion feature to be implemented')

# Preview
document.getElementById('preview-event').addEventListener 'click', ->
  title = document.getElementById('event-title').value
  description = document.getElementById('event-description').value
  start = document.getElementById('event-start').value
  end = document.getElementById('event-end').value
  previewContent = document.getElementById('preview-content')
  previewContent.innerHTML = """
    <h4 class='text-xl font-semibold text-purple-500'>#{title}</h4>
    <p class='text-gray-200 mt-2'>#{description}</p>
    <p class='text-gray-400 mt-2'>From: #{start} To: #{end}</p>
  """
  document.getElementById('event-preview').classList.remove('hidden')

# Form Submission
document.getElementById('event-form').addEventListener 'submit', (e) ->
  e.preventDefault()
  document.getElementById('event-status').textContent = 'Event created successfully!'
  document.getElementById('event-status').classList.remove('hidden')
  setTimeout ->
    document.getElementById('event-modal').classList.add('hidden')
    document.getElementById('event-status').classList.add('hidden')
  , 2000

document.addEventListener 'DOMContentLoaded', ->
  voiceCallBtn = document.getElementById 'voice-call-btn'
  scheduleMeetingBtn = document.getElementById 'schedule-meeting-btn'
  aiSuggestion = document.getElementById 'ai-suggestion'
  themeSelect = document.getElementById 'theme-select'

  voiceCallBtn.addEventListener 'click', -> alert 'Voice call feature (WebRTC to be integrated)'
  scheduleMeetingBtn.addEventListener 'click', -> window.location.href = window.messagesConfig.calendarUrl

  setInterval ->
    suggestions = ['Draft a project proposal', 'Analyze market trends', 'Create a virtual world map']
    aiSuggestion.textContent = suggestions[Math.floor(Math.random() * suggestions.length)]
  , 10000

  themeSelect.addEventListener 'change', (e) ->
    document.body.className = e.target.value
    fetch('/api/settings/theme', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ theme: e.target.value, user: 'kodoninja' })
    })
    .then((response) => response.json())
    .then((data) -> console.log 'Theme updated:', data)

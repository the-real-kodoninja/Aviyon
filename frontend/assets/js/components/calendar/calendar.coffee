# assets/js/components/calendar/calendar.coffee

# State Management
class CalendarState
  constructor: ->
    @currentDate = new Date()
    @currentView = 'month'
    @events = [
      { id: 1, title: 'KodoCity Meetup', start: '2025-05-15T10:00', end: '2025-05-15T12:00', category: 'meetups', location: 'KodoCity', isOffline: true }
      { id: 2, title: 'VR Workshop', start: '2025-05-10T14:00', end: '2025-05-10T16:00', category: 'workshops', location: 'Virtual', isOffline: true }
      { id: 3, title: 'Live Stream', start: '2025-05-09T18:00', end: '2025-05-09T20:00', category: 'live', location: 'Virtual', isOffline: true }
    ]
    @cachedEvents = new Map()
    @initOffline()

  initOffline: ->
    if 'caches' in window
      caches.open('calendar-cache').then (cache) =>
        cache.match('/events').then (response) =>
          if response
            response.json().then (data) => @events = data
          else
            @cacheEvents()
    @checkOnlineStatus()

  cacheEvents: ->
    if 'caches' in window
      caches.open('calendar-cache').then (cache) =>
        cache.put('/events', new Response(JSON.stringify(@events)))

  checkOnlineStatus: ->
    setInterval =>
      status = if navigator.onLine then 'Online' else 'Offline'
      document.getElementById('offline-status').textContent = status
    , 1000

# Render Functions
renderCalendar = (state) ->
  calendarView = document.getElementById('calendar-view')
  weekDayView = document.getElementById('week-day-view')
  calendarView.innerHTML = ''
  weekDayView.classList.add('hidden')
  calendarView.classList.add('animate-fade-in')

  month = state.currentDate.getMonth()
  year = state.currentDate.getFullYear()
  document.getElementById('current-month').textContent = "#{state.currentDate.toLocaleString('default', { month: 'long' })} #{year}"

  firstDay = new Date(year, month, 1).getDay()
  daysInMonth = new Date(year, month + 1, 0).getDate()

  # Header
  header = document.createElement('div')
  header.className = 'grid grid-cols-7 gap-1 bg-gray-700 p-2 text-center text-gray-200 font-semibold'
  header.innerHTML = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((day) -> "<div>#{day}</div>").join('')
  calendarView.appendChild(header)

  # Days Grid
  daysGrid = document.createElement('div')
  daysGrid.className = 'calendar-grid mt-1'
  for i in [0...42] # 6 weeks
    dayDiv = document.createElement('div')
    dayDiv.className = 'calendar-day relative'
    if i >= firstDay and i < firstDay + daysInMonth
      day = i - firstDay + 1
      daySpan = document.createElement('span')
      daySpan.className = 'text-gray-200'
      daySpan.textContent = day
      dayDiv.appendChild(daySpan)
      eventsForDay = state.events.filter (e) ->
        new Date(e.start).getDate() is day and new Date(e.start).getMonth() is month and new Date(e.start).getFullYear() is year
      if eventsForDay.length
        dots = document.createElement('div')
        dots.className = 'mt-2'
        dots.innerHTML = eventsForDay.map((e) -> "<span class='event-dot' style='background: #{getCategoryColor(e.category)}' data-id='#{e.id}'></span>").join('')
        dayDiv.appendChild(dots)
    daysGrid.appendChild(dayDiv)
  calendarView.appendChild(daysGrid)

  setupInteractivity(state, dayDiv)

renderMiniCalendar = (state) ->
  miniCalendar = document.getElementById('mini-calendar')
  miniCalendar.innerHTML = ''
  month = state.currentDate.getMonth()
  year = state.currentDate.getFullYear()
  firstDay = new Date(year, month, 1).getDay()
  daysInMonth = new Date(year, month + 1, 0).getDate()

  miniGrid = document.createElement('div')
  miniGrid.className = 'grid grid-cols-7 gap-1'
  for i in [0...42]
    dayDiv = document.createElement('div')
    dayDiv.className = 'w-8 h-8 flex items-center justify-center text-gray-200 cursor-pointer hover:bg-gray-600 rounded'
    if i >= firstDay and i < firstDay + daysInMonth
      day = i - firstDay + 1
      dayDiv.textContent = day
      dayDiv.addEventListener 'click', -> state.currentDate.setDate(day); renderCalendar(state); renderMiniCalendar(state)
    miniGrid.appendChild(dayDiv)
  miniCalendar.appendChild(miniGrid)

renderWeekDayView = (state, view) ->
  weekDayView = document.getElementById('week-day-view')
  document.getElementById('calendar-view').classList.add('hidden')
  weekDayView.classList.remove('hidden')
  weekDayView.innerHTML = if view == 'week' then '<div class="grid grid-cols-7 gap-1 bg-gray-700 p-2 text-center text-gray-200 font-semibold">Week View</div>' else '<div class="calendar-day h-96">Day View</div>'

# Utility Functions
getCategoryColor = (category) ->
  colors = { meetups: '#10b981', workshops: '#f59e0b', live: '#ef4444' }
  colors[category] or '#6b7280'

showEventDetails = (eventId, events) ->
  event = events.find((e) -> e.id == eventId)
  alert("Event: #{event.title}\nTime: #{event.start} - #{event.end}\nLocation: #{event.location}") if event

setupInteractivity = (state, dayDiv) ->
  dayDiv.addEventListener 'click', (e) ->
    if e.target.classList.contains('event-dot')
      showEventDetails(parseInt(e.target.dataset.id), state.events)
  dayDiv.addEventListener 'dragstart', (e) ->
    e.dataTransfer.setData('text/plain', e.target.dataset.day)
    e.target.classList.add('dragging')
  dayDiv.addEventListener 'dragend', (e) -> e.target.classList.remove('dragging')
  dayDiv.addEventListener 'dragover', (e) -> e.preventDefault()
  dayDiv.addEventListener 'drop', (e) ->
    e.preventDefault()
    fromDay = e.dataTransfer.getData('text')
    toDay = e.target.dataset.day
    console.log "Moved from #{fromDay} to #{toDay}"
    e.target.classList.remove('dragging')

# Initialize
state = new CalendarState()
renderCalendar(state)
renderMiniCalendar(state)

# Navigation and Controls
document.getElementById('prev-month').addEventListener 'click', ->
  state.currentDate.setMonth(state.currentDate.getMonth() - 1)
  renderCalendar(state)
  renderMiniCalendar(state)

document.getElementById('next-month').addEventListener 'click', ->
  state.currentDate.setMonth(state.currentDate.getMonth() + 1)
  renderCalendar(state)
  renderMiniCalendar(state)

document.getElementById('month-view').addEventListener 'click', ->
  state.currentView = 'month'
  renderCalendar(state)
  document.getElementById('month-view').classList.add('bg-indigo-600')
  document.getElementById('month-view').classList.remove('bg-gray-700')
  document.getElementById('week-view').classList.remove('bg-indigo-600')
  document.getElementById('week-view').classList.add('bg-gray-700')
  document.getElementById('day-view').classList.remove('bg-indigo-600')
  document.getElementById('day-view').classList.add('bg-gray-700')

document.getElementById('week-view').addEventListener 'click', ->
  state.currentView = 'week'
  renderWeekDayView(state, 'week')
  document.getElementById('week-view').classList.add('bg-indigo-600')
  document.getElementById('week-view').classList.remove('bg-gray-700')
  document.getElementById('month-view').classList.remove('bg-indigo-600')
  document.getElementById('month-view').classList.add('bg-gray-700')
  document.getElementById('day-view').classList.remove('bg-indigo-600')
  document.getElementById('day-view').classList.add('bg-gray-700')

document.getElementById('day-view').addEventListener 'click', ->
  state.currentView = 'day'
  renderWeekDayView(state, 'day')
  document.getElementById('day-view').classList.add('bg-indigo-600')
  document.getElementById('day-view').classList.remove('bg-gray-700')
  document.getElementById('month-view').classList.remove('bg-indigo-600')
  document.getElementById('month-view').classList.add('bg-gray-700')
  document.getElementById('week-view').classList.remove('bg-indigo-600')
  document.getElementById('week-view').classList.add('bg-gray-700')

document.getElementById('new-event-btn').addEventListener 'click', ->
  document.getElementById('event-modal').classList.remove('hidden')

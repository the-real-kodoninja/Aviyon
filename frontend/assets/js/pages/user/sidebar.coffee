document.addEventListener 'DOMContentLoaded', ->
  # Calendar Logic
  calendarDays = document.getElementById 'calendar-days'
  monthYear = document.getElementById 'month-year'
  prevMonth = document.getElementById 'prev-month'
  nextMonth = document.getElementById 'next-month'
  currentDate = new Date()
  currentMonth = currentDate.getMonth()
  currentYear = currentDate.getFullYear()

  renderCalendar = ->
    firstDay = new Date(currentYear, currentMonth, 1).getDay()
    daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate()
    monthYear.textContent = "#{currentDate.toLocaleString('default', { month: 'long' })} #{currentYear}"
    calendarDays.innerHTML = ''
    for i in [0...firstDay]
      calendarDays.innerHTML += '<div></div>'
    for day in [1..daysInMonth]
      calendarDays.innerHTML += "<div class='hover:bg-gray-700 p-1 rounded'>#{day}</div>"

  prevMonth.addEventListener 'click', ->
    currentMonth--
    if currentMonth < 0
      currentMonth = 11
      currentYear--
    currentDate = new Date(currentYear, currentMonth, 1)
    renderCalendar()

  nextMonth.addEventListener 'click', ->
    currentMonth++
    if currentMonth > 11
      currentMonth = 0
      currentYear++
    currentDate = new Date(currentYear, currentMonth, 1)
    renderCalendar()

  renderCalendar()

  # Live Activity Feed Simulation
  activityFeed = document.getElementById 'activity-feed'
  activities = [
    "Sahar liked a post • 2m ago",
    "Emmanuel shared an NFT • 5m ago",
    "Alice commented on a post • 10m ago"
  ]
  setInterval ->
    activity = activities[Math.floor(Math.random() * activities.length)]
    li = document.createElement 'li'
    li.className = 'flex items-center'
    li.innerHTML = "<span class='w-2 h-2 bg-green-400 rounded-full mr-2'></span><span>#{activity}</span>"
    activityFeed.prepend li
    if activityFeed.children.length > 5
      activityFeed.removeChild activityFeed.lastChild
  , 10000

  # Dark Mode Toggle
  darkModeToggle = document.getElementById 'dark-mode-toggle'
  toggleDot = document.querySelector '.toggle-dot'
  darkModeToggle.addEventListener 'change', ->
    if darkModeToggle.checked
      document.documentElement.classList.add 'dark'
      toggleDot.style.transform = 'translateX(24px)'
    else
      document.documentElement.classList.remove 'dark'
      toggleDot.style.transform = 'translateX(0)'

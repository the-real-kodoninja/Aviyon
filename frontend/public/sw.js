self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open('calendar-cache').then((cache) => {
      return cache.addAll([
        '/',
        '/build/calendar.js',
        '/build/css/calendar.css',
        '/templates/pages/calendar.html.twig'
      ]);
    })
  );
});

self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request);
    })
  );
});

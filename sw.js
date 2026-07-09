// Offline app-shell cache for Financial Hub.
//
// Only same-origin requests (the app shell) are handled here. Cross-origin
// calls — Supabase API responses carrying financial data — go straight to
// the network with no cache fallback and are never written to the cache.
const CACHE_NAME = 'financial-hub-v1';

self.addEventListener('install', event => {
  event.waitUntil(caches.open(CACHE_NAME).then(cache => cache.addAll(['./'])));
  self.skipWaiting();
});

self.addEventListener('activate', event => {
  event.waitUntil(self.clients.claim());
});

self.addEventListener('fetch', event => {
  if (new URL(event.request.url).origin !== self.location.origin) return;

  event.respondWith(
    fetch(event.request).catch(() =>
      caches.match(event.request).then(hit => hit || caches.match('./'))
    )
  );
});

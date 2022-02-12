// This script installs service_worker.js to provide PWA functionality to
// application. For more information, see:
// https://developers.google.com/web/fundamentals/primers/service-workers

var serviceWorkerVersion = null;
if ('serviceWorker' in navigator) {
  // Service workers are supported. Use them.
  window.addEventListener('load', function () {
    // Wait for registration to finish before dropping the <script> tag.
    // Otherwise, the browser will load the script multiple times,
    // potentially different versions.
    var serviceWorkerUrl = 'flutter_service_worker.js?v=' + serviceWorkerVersion;
    navigator.serviceWorker.register(serviceWorkerUrl)
      .then((reg) => {
        function waitForActivation(serviceWorker) {
          serviceWorker.addEventListener('statechange', () => {
            if (serviceWorker.state == 'activated') {
              console.log('Installed new service worker.');
            }
          });
        }
        if (!reg.active && (reg.installing || reg.waiting)) {
          // No active web worker and we have installed or are installing
          // one for the first time. Simply wait for it to activate.
          waitForActivation(reg.installing ?? reg.waiting);
        } else if (!reg.active.scriptURL.endsWith(serviceWorkerVersion)) {
          // When the app updates the serviceWorkerVersion changes, so we
          // need to ask the service worker to update.
          console.log('New service worker available.');
          reg.update();
          waitForActivation(reg.installing);
        } else {
          // Existing service worker is still good.
          console.log('Loading app from service worker.');
        }
      });
  });
}
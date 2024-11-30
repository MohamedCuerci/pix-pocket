// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./stylesheets/application.scss";  // Corrigido
import "bootstrap"

if ("serviceWorker" in navigator) {
  navigator.serviceWorker.register("/service-worker.js")
      .then(() => console.log("Service Worker registrado com sucesso."))
      .catch(error => console.error("Erro ao registrar Service Worker:", error));
}

console.log("Hello from application.js");
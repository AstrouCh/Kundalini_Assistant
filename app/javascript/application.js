// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

// ajouté pour le bug de delete practice
import "@rails/ujs"

 // idem
import { Turbo } from "@hotwired/turbo-rails";
Turbo.session.drive = false;  // Désactive Turbo pour tester la suppression

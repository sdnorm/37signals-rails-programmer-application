// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import NotificationController from "./notification_controller"
application.register("notification", NotificationController)

document.addEventListener("turbo:submit-end", function(event) {
  if (event.target.id === "date-parse-form") {
    event.target.reset();
  }
});
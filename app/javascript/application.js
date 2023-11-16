// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
import {sh_highlightDocument} from "shjs"
import "sh_ruby";
import "sh_html";
import "controllers"

// document.addEventListener("turbolinks:load", function(event) {
// alert('load');
  // sh_highlightDocument();
// });
document.addEventListener("DOMContentLoaded", function(event) {
  sh_highlightDocument();
});
// document.onload(() => {
// })

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme"
export default class extends Controller {
  static targets = ["sunIcon", "moonIcon"]

  connect() {
    console.log("Theme controller connected!")
    this.applyTheme(this.currentTheme)
  }

  toggle() {
    console.log("Toggle clicked! Current theme:", this.currentTheme)
    const newTheme = this.currentTheme === "dark" ? "light" : "dark"
    this.applyTheme(newTheme)
    this.persistTheme(newTheme)
  }

  applyTheme(theme) {
    console.log("Applying theme:", theme)
    if (theme === "dark") {
      document.documentElement.classList.add("dark")
    } else {
      document.documentElement.classList.remove("dark")
    }
    this.updateIcons(theme)
  }

  updateIcons(theme) {
    if (this.hasSunIconTarget && this.hasMoonIconTarget) {
      if (theme === "dark") {
        this.sunIconTarget.classList.remove("hidden")
        this.moonIconTarget.classList.add("hidden")
      } else {
        this.sunIconTarget.classList.add("hidden")
        this.moonIconTarget.classList.remove("hidden")
      }
    }
  }

  persistTheme(theme) {
    localStorage.setItem("theme", theme)
  }

  get currentTheme() {
    return localStorage.getItem("theme") || "light"
  }
}

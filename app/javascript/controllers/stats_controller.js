import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["counter"]
  static values = { count: Number }

  connect() {
    this.loadStats()
    this.updateDisplay()
  }

  loadStats() {
    const stored = localStorage.getItem('sobri-check-stats')

    if (stored) {
      this.stats = JSON.parse(stored)
    } else {
      this.stats = {
        totalChecks: 0,
        safeMessages: 0,
        warningMessages: 0,
        dangerMessages: 0,
        lastUsed: null
      }
    }
  }

  saveStats() {
    localStorage.setItem('sobri-check-stats', JSON.stringify(this.stats))
  }

  incrementCheck(status) {
    this.stats.totalChecks++
    this.stats.lastUsed = new Date().toISOString()

    switch(status) {
      case 'safe':
        this.stats.safeMessages++
        break
      case 'warning':
        this.stats.warningMessages++
        break
      case 'danger':
        this.stats.dangerMessages++
        break
    }

    this.saveStats()
    this.updateDisplay()
  }

  updateDisplay() {
    if (this.hasCounterTarget) {
      this.counterTarget.textContent = this.stats.totalChecks
    }
  }

  getStats() {
    return this.stats
  }

  reset() {
    this.stats = {
      totalChecks: 0,
      safeMessages: 0,
      warningMessages: 0,
      dangerMessages: 0,
      lastUsed: null
    }
    this.saveStats()
    this.updateDisplay()
  }
}

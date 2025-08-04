import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["messageInput", "submitButton", "clearButton", "form", "resultsContainer", "modal", "modalContent"]
  static values = { analyzing: Boolean }

  connect() {
    console.log("Sobri Check controller connected")
    this.updateButtonStates()
  }

  messageInputTargetConnected() {
    this.messageInputTarget.addEventListener('input', this.updateButtonStates.bind(this))
    this.messageInputTarget.addEventListener('keydown', this.handleKeydown.bind(this))
  }

  handleKeydown(event) {
    // Submit on Cmd+Enter or Ctrl+Enter
    if ((event.metaKey || event.ctrlKey) && event.key === 'Enter') {
      event.preventDefault()
      this.submit()
    }

    // Close modal on Escape
    if (event.key === 'Escape') {
      this.closeModal()
    }
  }

  updateButtonStates() {
    const hasText = this.messageInputTarget.value.trim().length > 0
    const isAnalyzing = this.analyzingValue

    // Update submit button
    if (this.hasSubmitButtonTarget) {
      this.submitButtonTarget.disabled = isAnalyzing || !hasText

      if (isAnalyzing) {
        this.submitButtonTarget.text = "Analyzing..."
      } else {
        this.submitButtonTarget.text = '🔍 Check with AI'
      }
    }

    // Update clear button
    if (this.hasClearButtonTarget) {
      this.clearButtonTarget.disabled = isAnalyzing
      this.clearButtonTarget.disabled = hasText ? false : true
    }
  }

  submit() {
    if (this.messageInputTarget.value.trim().length === 0 || this.analyzingValue) {
      return
    }

    this.analyzingValue = true
    this.updateButtonStates()

    // Add visual feedback
    this.messageInputTarget.classList.add('ring-2', 'ring-blue-300')

    // Show loading state in results
    if (this.hasResultsContainerTarget) {
      this.resultsContainerTarget.innerHTML = `
        <div class="mb-8 animate-pulse">
          <div class="bg-gray-50 border border-gray-200 rounded-xl p-8">
            <div class="flex items-center justify-center">
              <svg class="animate-spin h-8 w-8 text-blue-600 mr-3" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              <span class="text-lg text-gray-600">AI is analyzing your message...</span>
            </div>
          </div>
        </div>
      `
    }

    this.formTarget.requestSubmit()
  }

  handleSubmitEnd() {
    this.analyzingValue = false
    this.updateButtonStates()
    this.messageInputTarget.classList.remove('ring-2', 'ring-blue-300')

    // Update stats if we have a stats controller
    const statsController = this.application.getControllerForElementAndIdentifier(
      document.querySelector('[data-controller*="stats"]'),
      'stats'
    )

    // Extract status from the results to update stats - be defensive about missing elements
    if (this.hasResultsContainerTarget && statsController) {
      const resultsContainer = this.resultsContainerTarget
      const statusElement = resultsContainer.querySelector('[class*="bg-green-50"], [class*="bg-yellow-50"], [class*="bg-red-50"]')

      if (statusElement) {
        let status = 'safe'

        if (statusElement.classList.contains('bg-yellow-50')) status = 'warning'
        if (statusElement.classList.contains('bg-red-50')) status = 'danger'

        statsController.incrementCheck(status)
      }
    }

    // Show notification
    this.showNotification("Analysis complete! Opening results in modal...")

    // Automatically show modal with results after a brief delay
    setTimeout(() => {
      this.showModal()
    }, 500)
  }

  showModal() {
    if (this.hasModalTarget && this.hasResultsContainerTarget) {
      // Copy results to modal, excluding the "View in Modal" button
      if (this.hasModalContentTarget) {
        const resultsClone = this.resultsContainerTarget.cloneNode(true)

        // Remove the "View in Modal" button from the clone
        const modalButton = resultsClone.querySelector('button[onclick*="showModal"]')

        if (modalButton) {
          modalButton.closest('div').remove()
        }

        this.modalContentTarget.innerHTML = resultsClone.innerHTML
      }

      // Show modal with animation
      this.modalTarget.classList.remove('hidden')
      this.modalTarget.classList.add('flex')

      // Animate in
      setTimeout(() => {
        const modalContent = this.modalTarget.querySelector('.modal-content')

        if (modalContent) {
          modalContent.classList.add('scale-100', 'opacity-100')
          modalContent.classList.remove('scale-95', 'opacity-0')
        }
      }, 10)

      // Prevent body scroll
      document.body.style.overflow = 'hidden'
    } else {
      console.log("Modal targets not found:", {
        hasModal: this.hasModalTarget,
        hasResults: this.hasResultsContainerTarget
      })
    }
  }

  closeModal() {
    if (this.hasModalTarget) {
      // Animate out
      const modalContent = this.modalTarget.querySelector('.modal-content')

      if (modalContent) {
        modalContent.classList.add('scale-95', 'opacity-0')
        modalContent.classList.remove('scale-100', 'opacity-100')
      }

      setTimeout(() => {
        this.modalTarget.classList.add('hidden')
        this.modalTarget.classList.remove('flex')
      }, 200)

      // Restore body scroll
      document.body.style.overflow = 'auto'
    }
  }

  showNotification(message) {
    // Create notification element
    const notification = document.createElement('div')

    notification.className = 'fixed top-4 right-4 bg-blue-600 text-white px-6 py-3 rounded-lg shadow-lg z-50 animate-slide-down'
    notification.innerHTML = `
      <div class="flex items-center">
        <span class="mr-2">✨</span>
        <span>${message}</span>
      </div>
    `

    document.body.appendChild(notification)

    // Remove after 3 seconds
    setTimeout(() => {
      notification.style.opacity = '0'
      notification.style.transform = 'translateY(-20px)'

      setTimeout(() => {
        notification.remove()
      }, 300)
    }, 3000)
  }

  clear() {
    if (this.analyzingValue) return

    this.messageInputTarget.value = ''

    this.messageInputTarget.focus()
    this.updateButtonStates()

    // Clear results with animation
    if (this.hasResultsContainerTarget) {
      this.resultsContainerTarget.style.opacity = '0'

      setTimeout(() => {
        this.resultsContainerTarget.innerHTML = ''
        this.resultsContainerTarget.style.opacity = '1'
      }, 200)
    }
  }

  autoResize() {
    const textarea = this.messageInputTarget

    textarea.style.height = 'auto'
    textarea.style.height = Math.min(textarea.scrollHeight, 200) + 'px'
  }

  stopPropagation(event) {
    event.stopPropagation()
  }
}

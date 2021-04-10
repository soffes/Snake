import AppKit
import SwiftUI

// Adapted from https://stackoverflow.com/a/61155272/118631
struct KeyEventHandling: NSViewRepresentable {

	// MARK: - Types

	typealias Handler = (NSEvent) -> Void

	private class KeyView: NSView {
		var handler: Handler

		init(handler: @escaping Handler) {
			self.handler = handler
			super.init(frame: .zero)
		}

		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		override var acceptsFirstResponder: Bool {
			true
		}

		override func keyDown(with event: NSEvent) {
			super.keyDown(with: event)
			handler(event)
		}
	}

	// MARK: - Properties

	private var handler: Handler

	// MARK: - Initializers

	init(handler: @escaping Handler) {
		self.handler = handler
	}

	// MARK: - NSViewRepresentable

	func makeNSView(context: Context) -> NSView {
		let view = KeyView(handler: handler)
		DispatchQueue.main.async {
			view.window?.makeFirstResponder(view)
		}
		return view
	}

	func updateNSView(_ nsView: NSView, context: Context) {}
}

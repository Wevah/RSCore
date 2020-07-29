//
//  WebViewWindowController.swift
//  RSCore
//
//  Created by Brent Simmons on 11/13/17.
//  Copyright © 2017 Ranchero Software, LLC. All rights reserved.
//
#if os(macOS)
import AppKit
import WebKit

public final class WebViewWindowController: NSWindowController {

	@IBOutlet private var webview: WKWebView!
	private var title: String!
    
	public convenience init(title: String) {
		self.init(windowNibName: "WebViewWindow")
		self.title = title
        
        guard let _ = Bundle.module.path(forResource: "WebViewWindow", ofType: "xib") else {
            print("No file at path.")
            return
        }
        
        guard let _ = Bundle.main.path(forResource: "WebViewWindow", ofType: "xib") else {
            print("No file at path.")
            return
        }
    }

	public override func windowDidLoad() {

		window!.title = title
	}

	public func displayContents(of path: String) {

		// We assume there might be images, style sheets, etc. contained by the folder that the file appears in, so we get read access to the parent folder.

		let _ = self.window

		let fileURL = URL(fileURLWithPath: path)
		let folderURL = fileURL.deletingLastPathComponent()

		webview.loadFileURL(fileURL, allowingReadAccessTo: folderURL)
	}
}
#endif

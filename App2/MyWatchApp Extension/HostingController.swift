//
//  HostingController.swift
//  MyWatchApp Extension
//
//  Created by Stefano D’Amato on 16/06/21.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<StartView> {
    override var body: StartView {
        return StartView()
    }
}

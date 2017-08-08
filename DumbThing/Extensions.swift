//
//  Extensions.swift
//  DumbThing
//
//  Created by Jeffrey Blagdon on 8/8/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
extension UITableView {
    /// Convenience wrapper for dequeueReusableCell. Uses type inference from call site.
    ///
    /// - Returns: An optional UITableViewCell of the inferred type
    func dequeue<A: UITableViewCell>() -> A? {
        return dequeueReusableCell(withIdentifier: String(describing: A.self)) as? A
    }

    /// Convenience wrapper for register. Uses String(describing:) to generate the reuse identifier.
    ///
    /// - Parameter cellType: The type of cell to be registered.
    func register(_ cellType: AnyClass) {
        self.register(cellType, forCellReuseIdentifier: String(describing: cellType))
    }
}

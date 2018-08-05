//
//  ModalRootViewController.swift
//  Swift-Sample-UIPageViewController+modal
//
//  Created by A10 Lab Inc. nobuy on 2018/07/11.
//  Copyright © 2018年 A10 Lab Inc. nobuy. All rights reserved.
//

import UIKit

class ModalRootViewController: UIViewController {

    private var pageViewController: UIPageViewController?

    private let dataSource: [DataItem]

    init(items: [DataItem]) {
        self.dataSource = items
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        let vc = DataViewController(item: dataSource.first!)
        let viewControllers = [vc]
        pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)

        pageViewController?.dataSource = self

        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)

        pageViewController!.view.bounds = view.bounds
        pageViewController!.didMove(toParentViewController: self)
    }
}

extension ModalRootViewController {
    private func viewControllerAtIndex(_ index: Int) -> DataViewController? {
        if (dataSource.count == 0) || (index >= dataSource.count) { return nil }
        return DataViewController(item: dataSource[index])
    }
    private func indexOfViewController(_ viewController: DataViewController) -> Int {
        return dataSource.index(where: { return $0.title == viewController.item.title }) ?? NSNotFound
    }
}

// MARK: UIPageViewControllerDataSource
extension ModalRootViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) { return nil }
        index -= 1
        let vc = viewControllerAtIndex(index)
        return vc
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound { return nil }
        index += 1
        if index == dataSource.count { return nil }
        let vc = viewControllerAtIndex(index)
        return vc
    }
}

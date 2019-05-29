//
//  WalkThroughPageViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 14/02/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit

class WalkThroughPageViewController: UIPageViewController {

    fileprivate lazy var pages : [UIViewController] = {
        return [
            UIViewController.getViewController(FirstTutorialViewController.self, storyboard: UIStoryboard.Storyboard.Walkthrough.object),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "02-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "03-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "04-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "05-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "06-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "07-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "08-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "09-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "10-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "11-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "12-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "13-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "14-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "15-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "16-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "17-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "18-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "19-min")),
            TutorialViewController(withImage: UIImage(imageLiteralResourceName: "20-min")),
            UIViewController.getViewController(LastTutorialViewController.self, storyboard: UIStoryboard.Storyboard.Walkthrough.object)
        ]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate   = self
        self.dataSource = self
        
        if let firstVC = pages.first
        {
             self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        self.hideNavigationBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func TutorialViewController(withImage image:UIImage)->TutorialScreenViewController {
        let tutorialViewController = UIViewController.getViewController(TutorialScreenViewController.self, storyboard: UIStoryboard.Storyboard.Walkthrough.object)
        tutorialViewController.image = image
        return tutorialViewController
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension WalkThroughPageViewController : UIPageViewControllerDataSource, UIPageViewControllerDelegate
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0          else { return nil }
        
        guard pages.count > previousIndex else { return nil        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else { return nil }
        
        guard pages.count > nextIndex else { return nil         }
        
        return pages[nextIndex]
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
}

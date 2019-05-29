

import UIKit

class SideMenuViewController: BaseViewController {
    
    enum SIDE_MENU_OPTIONS: Int{
        case Imprint
        case Acknowledgements
        case Feedback
        case Contact
        case Disclaimer
        case Legal
    }
    
    @IBOutlet weak var tblView: UITableView!
    //Side Menu Data Source
    var dataSource: [(name: String, image: UIImage, subTitle: String)] = []
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didLogOutUser), name: AppConstants.NSNotificationNames.USER_LOG_OUT_NOTIFICATION, object: nil)
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.prepareDataSource()
        self.viewCustomization()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if isMovingToParent {
            NotificationCenter.default.removeObserver(self)
        }
    }
    //MARK: Customize View
    
    /// Method used to customize view appearance
    func viewCustomization(){
        self.tableViewInitalization()
    }
    
    func prepareDataSource(){
        
        self.dataSource = !UserDefaultUtility.retrieveBoolForKey(AppConstants.UserDefaultKeys.IS_ALREADY_LOGIN)
        ? [
            (AppConstants.ScreenSpecificConstant.SideMenuScreen.IMPRINT, #imageLiteral(resourceName: "ic_side_menu"), ""),
          //  (AppConstants.ScreenSpecificConstant.SideMenuScreen.ACKNOWLEDGEMENTS, #imageLiteral(resourceName: "ic_radio_button_unchecked_white"), ""),
            (AppConstants.ScreenSpecificConstant.SideMenuScreen.CONTACT, #imageLiteral(resourceName: "ic_side_menu"), ""),
            (AppConstants.ScreenSpecificConstant.SideMenuScreen.DISCLAIMER, #imageLiteral(resourceName: "ic_side_menu"), ""),
            (AppConstants.ScreenSpecificConstant.SideMenuScreen.LEGAL, #imageLiteral(resourceName: "ic_side_menu"), "")
            ] : [
                (AppConstants.ScreenSpecificConstant.SideMenuScreen.IMPRINT, #imageLiteral(resourceName: "ic_side_menu"), ""),
                //  (AppConstants.ScreenSpecificConstant.SideMenuScreen.ACKNOWLEDGEMENTS, #imageLiteral(resourceName: "ic_radio_button_unchecked_white"), ""),
                (AppConstants.ScreenSpecificConstant.SideMenuScreen.CONTACT, #imageLiteral(resourceName: "ic_side_menu"), ""),
                (AppConstants.ScreenSpecificConstant.SideMenuScreen.DISCLAIMER, #imageLiteral(resourceName: "ic_side_menu"), ""),
                (AppConstants.ScreenSpecificConstant.SideMenuScreen.LEGAL, #imageLiteral(resourceName: "ic_side_menu"), ""),
                (AppConstants.ScreenSpecificConstant.SideMenuScreen.LOG_OUT, #imageLiteral(resourceName: "ic_side_menu"), "")
        ]
    }

    
    
    /// Method to initalize table view
    func tableViewInitalization(){
        self.tblView.registerTableViewCell(tableViewCell: SideMenuItemTableViewCell.self)
        self.tblView.registerTableViewHeaderFooterView(tableViewHeaderFooter: SideMenuHeaderFooterView.self)
        self.tblView.reloadData()
    }
    @IBAction func btnDismissSideMenuClick(_ sender: Any) {
        self.closeSideMenu()
    }
    
    func closeSideMenu(){
        AppDelegate.sharedInstance.kMainViewController?.toggleLeftView(animated: true, completionHandler: nil)
    }
    @objc func didLogOutUser()
    {
        self.prepareDataSource()
        self.tblView.reloadData()
    }
}

//MARK: UITable View Delegate and datasource
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(withCellType: SideMenuItemTableViewCell.self)
        let dataSourceCell = self.dataSource[indexPath.row]
        cell.bind(withItemName: dataSourceCell.name, imgItem: dataSourceCell.image, subTitle: dataSourceCell.subTitle)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToScreenWithSelectedIndex(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.getHeader(withHeaderType: SideMenuHeaderFooterView.self)
    return header
    }
    func navigateToScreenWithSelectedIndex(index: Int){
                    self.closeSideMenu()
        switch index {
        case 0:
            self.navigateToImprintScreen()
            break
        case 1:
            self.navigateToContactScreen()
            break
        case 2:
            self.navigateToDisclaimerScreen()
            break
        case 3:
            self.navigateToLegalScreen()
            break
        case 4:
            self.logout()
            break
        default:
            break
        }
    }
    private func navigateToLegalScreen()
    {
        let legalVC = UIViewController.getViewController(LegalViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
        UIApplication.shared.visibleViewController?.navigationController?.pushViewController(legalVC, animated: true)
    }
    private func navigateToImprintScreen()
    {
        let imprintVC = UIViewController.getViewController(ImprintViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
        UIApplication.shared.visibleViewController?.navigationController?.pushViewController(imprintVC, animated: true)
    }
    private func navigateToContactScreen()
    {
        let contactVC = UIViewController.getViewController(ContactViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
        UIApplication.shared.visibleViewController?.navigationController?.pushViewController(contactVC, animated: true)
    }
    private func navigateToDisclaimerScreen()
    {
        let disclaimerVC = UIViewController.getViewController(DisclaimerViewController.self, storyboard: UIStoryboard.Storyboard.Main.object)
        UIApplication.shared.visibleViewController?.navigationController?.pushViewController(disclaimerVC, animated: true)
    }
    
}

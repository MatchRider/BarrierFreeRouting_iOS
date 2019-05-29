//
//  InstructionsViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 10/08/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
enum DirectionInstruction:Int
{
    case Left
    case Right
    case Sharpleft
    case Sharpright
    case SlightLeft
    case SlightRight
    case Straight
    case EnterRoundabout
    case ExitRoundabout
    case UTurn
    case Goal
    case Depart
    case KeepLeft
    case KeepRight
}

class InstructionsViewController: BaseViewController {
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var tableViewInstructions: UITableView!
    
    var steps : [Steps]!
    var segments : [Segments]!
    var hasMidpoint = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewInstructions.delegate = self
        self.tableViewInstructions.dataSource = self
        self.tableViewInstructions.estimatedRowHeight = 80
        self.labelTitle.text = "Instructions".localized()
        self.steps = segments[0].steps
        if segments.count == 2 {
            let ctoBSteps =  (segments[1].steps)!
            self.steps.append(contentsOf:ctoBSteps[1...ctoBSteps.count-1])
            hasMidpoint = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    fileprivate func instructionSymbol(forType type:DirectionInstruction)->UIImage
    {
        switch type {
        case .Left:
            return #imageLiteral(resourceName: "turnLeft")
            
        case .Right:
            return #imageLiteral(resourceName: "turnRight")
            
        case .Sharpleft:
            return #imageLiteral(resourceName: "turnLeft")
            
        case .Sharpright:
            return #imageLiteral(resourceName: "turnRight")
            
        case .SlightLeft:
            return #imageLiteral(resourceName: "slightLeft")
            
        case .SlightRight:
            return #imageLiteral(resourceName: "slightRight")
            
        case .Straight:
            return #imageLiteral(resourceName: "ic_arrow_upward")
            
        case .EnterRoundabout:
            return #imageLiteral(resourceName: "baseline_refresh_black_24pt")
            
        case .ExitRoundabout:
            return #imageLiteral(resourceName: "baseline_refresh_black_24pt")
            
        case .UTurn:
            return #imageLiteral(resourceName: "uTurn")
    
        case .Depart:
            return #imageLiteral(resourceName: "pin_a")
            
        case .KeepLeft:
            return #imageLiteral(resourceName: "keepLeft")
            
        case .KeepRight:
            return #imageLiteral(resourceName: "keepRight")
           
        case .Goal:
            return #imageLiteral(resourceName: "pin_b")
        }
    }
}
extension InstructionsViewController : UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionTableViewCell") as! InstructionTableViewCell
        let step = self.steps[indexPath.row]
        let directionInstruction = DirectionInstruction.init(rawValue: step.type!)!
         cell.imageViewSign.image = instructionSymbol(forType: directionInstruction)
        
        if (directionInstruction == .Goal && indexPath.row != self.steps.count-1 && hasMidpoint) {
                cell.imageViewSign.image = #imageLiteral(resourceName: "pin_b")
        } else if (directionInstruction == .Goal && indexPath.row == self.steps.count-1 && hasMidpoint) {
            cell.imageViewSign.image = #imageLiteral(resourceName: "pin_c")
        }
       
        if step.name != "" {
            cell.labelInstructions.text = "\(step.instruction ?? "")\n-- \(step.name ?? "")"
        } else {
             cell.labelInstructions.text = step.instruction
        }
        
        if AppConstants.AppLanguages.DEFAULT_LANGUAGE == "de" {
            cell.labelDistance.text = String(format:" %.2f m",((step.distance ?? 0.0))).replacingOccurrences(of: ".", with: ",")
        }
        else {
            cell.labelDistance.text = String(format:" %.2f m",((step.distance ?? 0.0)))
        }
        return cell
    }
}

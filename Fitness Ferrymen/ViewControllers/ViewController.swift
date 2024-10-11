//
//  ViewController.swift
//  Fitness Ferrymen
//
//  Created by Miles Belknap on 4/24/21.
//  Copyright © 2021 Miles Belknap. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import CoreData

class ChangeGoalsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userWeightTextField: UITextField!
    
    @IBOutlet weak var userHeightTextField: UITextField!
    
    @IBOutlet weak var userAgeTextField: UITextField!
    
    @IBOutlet weak var userGenderSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var userGoalSegmentedController: UISegmentedControl!
    
    @IBOutlet weak var userExerciseLevelSegmentedController: UISegmentedControl!
    
    @IBOutlet weak var startYourJourneyButton: UIButton!
    
    @IBOutlet weak var startYourJourneyView: UIView!
    
    //user exercise levels
    public var littleExercise: Bool = false
    public var lightExercise: Bool = false
    public var moderateExercise: Bool = false
    public var heavyExercise: Bool = false
    public var exerciseLevel: Double = 0
    
    //Goals
    public var isMuscleGaining: Bool = false
    public var isMaintaining: Bool = false
    public var isLosingWeight: Bool = false
    
    //userInfo
    public var userWeight: Double = 0.0
    public var userHeight: Double = 0.0
    public var userAge: Double  = 0.0
    public var isMale: Bool = false
    public var isFemale: Bool = false
    
    //userInfo
    var BRM: Double = 0
    var TDEE: Double = 0
    
    //Macros
    var totalCaloriesRequired: Double = 0.0
    var proteinGramsRequired: Double = 0.0
    var proteinCalsRequired: Double = 0.0
    var carbsGramsRequired: Double = 0.0
    var carbsCalsRequired: Double = 0.0
    var fatGramsRequired: Double = 0.0
    var fatCalsRequired: Double = 0.0
    
    //creates the TDEE
    func createTDEE(uWeight: Double, uHeight:Double,uAge:Double) -> Double{
        let level = exerciseLevelFunc();
        let gender = genderFunc();
        let x =  (655 + (uWeight * 4.35) + (uHeight * 4.7)) - ((uAge * 4.7) * level + gender)
        return x
    }
    
    //total calories calculated when user chooses to gain muscle
    func createNewTotalCaloriesRequiredForMuscles(uWeight: Double, uHeight:Double,uAge:Double) -> Double{
        let tdee = createTDEE(uWeight: uWeight, uHeight: uHeight, uAge: uAge)
        fatGramsRequired = (tdee * 0.30) / 9
        fatCalsRequired = fatGramsRequired * 9
        
        proteinGramsRequired = uWeight * 1.5
        proteinCalsRequired = uWeight * 4
        
        carbsCalsRequired = tdee - (fatGramsRequired * 9) - (proteinGramsRequired * 4)
        carbsGramsRequired = carbsCalsRequired / 4
        
        return fatCalsRequired + proteinCalsRequired + carbsCalsRequired + tdee
    }
    
    //total calories calculated when user chooses to lose weight
    func createNewTotalCaloriesRequiredForLosingWeight(uWeight: Double, uHeight:Double,uAge:Double) -> Double{
        let tdee = createTDEE(uWeight: uWeight, uHeight: uHeight, uAge: uAge)
        fatGramsRequired = (tdee * 0.30) / 9
        fatCalsRequired = fatGramsRequired * 9
        
        proteinGramsRequired = uWeight * 1
        proteinCalsRequired = uWeight * 4
        
        carbsCalsRequired = tdee - (fatGramsRequired * 9) - (proteinGramsRequired * 4)
        carbsGramsRequired = carbsCalsRequired / 4
        
        return fatCalsRequired + proteinCalsRequired + carbsCalsRequired + tdee - 1000
    }
    
    //total calories calculated when user chooses to maintain weight
    func createNewTotalCaloriesForMaintaining(uWeight: Double, uHeight:Double,uAge:Double) -> Double{
        let tdee = createTDEE(uWeight: uWeight, uHeight: uHeight, uAge: uAge)
        fatGramsRequired = (tdee * 0.30) / 9
        fatCalsRequired = fatGramsRequired * 9
        
        proteinGramsRequired = uWeight * 1.5
        proteinCalsRequired = uWeight * 4
        
        carbsCalsRequired = tdee - (fatGramsRequired * 9) - (proteinGramsRequired * 4)
        carbsGramsRequired = carbsCalsRequired / 4
        
        return fatCalsRequired + proteinCalsRequired + carbsCalsRequired + tdee - 400
    }
    
    //user selected their gender
    @IBAction func onGenderSegmentTapped(_ sender: UISegmentedControl) {
        switch userGenderSegmentedControl.selectedSegmentIndex
        {
        case 0:
            isMale = true
            isFemale = false
        case 1:
            isFemale = true
            isMale = false
        default:
            isMale = true
            isFemale = false
        }
    }
    
    //user selected their goal
    @IBAction func onGoalsSegmentTapped(_ sender: UISegmentedControl) {
        switch userGoalSegmentedController.selectedSegmentIndex
        {
        case 0:
            isMuscleGaining = true
            isLosingWeight = false
            isMaintaining = false
        case 1:
            isMaintaining = true
            isMuscleGaining = false
            isLosingWeight = false
        case 2:
            isLosingWeight = true
            isMaintaining = false
            isMuscleGaining = false
        default:
            isMuscleGaining = true
            isLosingWeight = false
            isMaintaining = false
        }
    }
    
    //user selected their exercise goal
    @IBAction func onExerciseLevelSegmentTapped(_ sender: UISegmentedControl){
        switch userExerciseLevelSegmentedController.selectedSegmentIndex
        {
        case 0:
            littleExercise = true
            lightExercise = false
            moderateExercise = false
            heavyExercise = false
        case 1:
            littleExercise = false
            lightExercise = true
            moderateExercise = false
            heavyExercise = false
        case 2:
            littleExercise = false
            lightExercise = false
            moderateExercise = true
            heavyExercise = false
        case 3:
            littleExercise = false
            lightExercise = false
            moderateExercise = false
            heavyExercise = true
        default:
            littleExercise = true
            lightExercise = false
            moderateExercise = false
            heavyExercise = false
        }
    }
    
    //if statements for exercise level func
    func exerciseLevelFunc() -> Double{
        if littleExercise == true{
            return 1.2;
        }
        if lightExercise == true{
            return 1.375;
        }
        if moderateExercise == true{
            return 1.55;
        }
        if heavyExercise == true{
            return 1.725
        }
        return 0.0
        }
    
    //if statements for exercise level func
    func genderFunc() -> Double{
        if isFemale == true{
            return -161;
        }
        if isMale == true{
        return 5;
        }
        return 0.0
    }
    
    //user tapped start journey button
    @IBAction func startJourneyButtonTapped(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var totalCalRequired = 0;
        
        userWeight = Double(userWeightTextField.text!) ?? 0.0
        userHeight = Double(userHeightTextField.text!) ?? 0.0
        userAge = Double(userAgeTextField.text!) ?? 0.0
        
        
        // if call
        if isMuscleGaining == true
        {
            totalCalRequired = Int(Double(createNewTotalCaloriesRequiredForMuscles(uWeight: userWeight, uHeight: userHeight, uAge: userAge)).rounded())
        }
        
        if isLosingWeight == true
        {
            totalCalRequired = Int(Double(createNewTotalCaloriesRequiredForLosingWeight(uWeight: userWeight, uHeight: userHeight, uAge: userAge)).rounded())
        }
        
        if isMaintaining == true
        {
            totalCalRequired = Int(Double(createNewTotalCaloriesForMaintaining(uWeight: userWeight, uHeight: userHeight, uAge: userAge)).rounded())
        }
        
        do {
            let result = try context.fetch(UserInfo.fetchRequest())
            
            if(result.count > 0){
                let data = result[0] as! UserInfo
                data.totalCalRequired = totalCalRequired
            }
            else{
                let newUserDetails = UserInfo(entity: UserInfo.entity(), insertInto:context)
                newUserDetails.totalCalRequired = totalCalRequired
            }
            print("total Calories Required = \(totalCalRequired)")
            print("tdee = \(TDEE)")
            print("fat Cals Required = \(fatCalsRequired)")
            print("protein = \(proteinCalsRequired)")
            print("carbs = \(carbsCalsRequired)")
            
        }
        catch{
            //error
        }
        
        do {
            try context.save()
        }catch{
            print("context save error")
        }
        
        
        self.navigationController?.popViewController(animated: true)
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        startYourJourneyView.layer.shouldRasterize = true
        startYourJourneyView.layer.rasterizationScale = UIScreen.main.scale
        startYourJourneyView.layer.cornerRadius = 15
        
        self.userWeightTextField.delegate = self
        self.userAgeTextField.delegate = self
        self.userHeightTextField.delegate = self
    }
    
}

class GoalsViewController: UIViewController {
    
    @IBOutlet weak var userNeededCalories: UILabel!
    
    
    @IBOutlet weak var totalCaloriesView: UIView!
    
    @IBOutlet weak var startNewGoalView: UIView!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserInfo")
    
    @IBOutlet weak var imageView: UIView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
              
        totalCaloriesView.layer.shouldRasterize = true
        totalCaloriesView.layer.rasterizationScale = UIScreen.main.scale
        totalCaloriesView.layer.cornerRadius = 15
        
        
        startNewGoalView.layer.shouldRasterize = true
        startNewGoalView.layer.rasterizationScale = UIScreen.main.scale
        startNewGoalView.layer.cornerRadius = 15
    }
    
    
    func calcTotalCalories(totalCalRequired: Int)-> String{
        
        // take passed in variables, do a caluation and pass back the value
        
        
        return "\(totalCalRequired)"
    }
    
    override func viewWillAppear(_ animated:Bool){
        super.viewWillAppear(animated)
        
        do {
            let result = try context.fetch(UserInfo.fetchRequest())
            if(result.count > 0){
                let data = result[0] as! UserInfo
                print("goals totalCalRequired = \(data.totalCalRequired)")
                if(data.totalCalRequired != 0){
                    userNeededCalories.text = String("\(calcTotalCalories(totalCalRequired: data.totalCalRequired))")
                }
            }
            
        } catch{
            //                   error
        }
    }
    
    @IBAction func startNewGoalBtnTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "change_goalsVc") as! ChangeGoalsViewController
        navigationController?.pushViewController(vc,animated: true)
    }
}

class LogViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(model.name ?? "") \(model.caloriesTaken ?? "")"
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            
            let alert = UIAlertController(title: "Edit Item", message: "Edit your item", preferredStyle: .alert)
            alert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                textField.placeholder = "Name"
            })
            alert.textFields?.first?.text = item.name
            alert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                textField.placeholder = "Calories"
                textField.text = item.caloriesTaken
            })
            
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?[0], let newName = field.text, let calField = alert.textFields?[1], let newCalText = calField.text, !newName.isEmpty else{
                    return
                }
                self?.updateItem(item: item, newName: newName, newCaloriesTaken: newCalText)
            }))
            
            self.present(alert, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        
        present(sheet, animated: true)
        
    }
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Meals")
    
    private var models = [Meals]()
    
    var caloriesRemaining: String = ""
    
    static var totalCaloriesForLog: String = ""
    
    @IBOutlet weak var displayCalories: UIView!
    
    @IBOutlet weak var caloriesRemainingLabel: UILabel!
    
    @State private var isShowingCongrats = false
    
    let mealsTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    override func viewDidLoad(){
        super.viewDidLoad()

        
        //tableViewStuff
        view.addSubview(mealsTableView)
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
        mealsTableView.frame = CGRect(x: 0, y: 340, width: 414, height: 420)
        self.mealsTableView.backgroundColor = UIColor.darkGray
        getAllItems()
        
        //shadow of view
        displayCalories.layer.shouldRasterize = true
        displayCalories.layer.rasterizationScale = UIScreen.main.scale
        displayCalories.layer.cornerRadius = 15
        
        //navigation Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        getAllItems()
        setDisplayText()
    }
    
    
    func setDisplayText(){
           do {
               let result = try context.fetch(UserInfo.fetchRequest())
               let meals = try context.fetch(Meals.fetchRequest()) as [Meals]
               var caloriesConsumed = 0;
               if(result.count > 0){
                   let data = result[0] as! UserInfo
                   for number in meals {
                    caloriesConsumed = caloriesConsumed + (number.caloriesTaken! as NSString).integerValue
                   }
                   caloriesRemaining = String(data.totalCalRequired - caloriesConsumed)
                   caloriesRemainingLabel.text = caloriesRemaining
                
                //resets calories remaining every 24 hours
                if let date = UserDefaults.standard.object(forKey: "savedTime") as? Date {
                         if let diff = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour, diff >= 24 {
                          caloriesRemaining = String(data.totalCalRequired)
                         }
                      }
               }
           } catch {}
    }
    
    @objc private func didTapAdd(totalCalRequired: Double) {
        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Name"
        })
        alert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Calories"
        })
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?[0], let text = field.text, let calField = alert.textFields?[1], let calText = calField.text, !text.isEmpty else{
                return
            }
            self?.createItem(name: text, caloriesTaken: calText)
        }))
        
        present(alert, animated: true)
        
    }

    func getAllItems(){
        do{
            models = try context.fetch(Meals.fetchRequest())
            DispatchQueue.main.async {
                self.mealsTableView.reloadData()
            }
        } catch{
            //            error
        }
    }
    
    func createItem(name: String, caloriesTaken: String){
        let newItem = Meals(context: context)
        newItem.name = name
        newItem.caloriesTaken = caloriesTaken
        
        do {
            try context.save()
            getAllItems()
            setDisplayText()
        }catch{
            //            error
        }
    }
    
    func deleteItem(item: Meals){
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
            setDisplayText()
        }catch{
            //            error
        }
    }
    
    func updateItem(item: Meals, newName: String, newCaloriesTaken: String){
        item.name = newName
        item.caloriesTaken = newCaloriesTaken
        
        do {
            try context.save()
            getAllItems()
            setDisplayText()
        }catch{
            //            error
        }
    }
    
}

class planViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserInfo")
    
    private var modelsPlan = [UserInfo]()
    
    @IBOutlet weak var planView: UIView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelsPlan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = modelsPlan[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(model.title) \(model.caloriesPlanned)"
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        let item = modelsPlan[indexPath.row]
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            
            let alert = UIAlertController(title: "Edit Item", message: "Edit your item", preferredStyle: .alert)
            alert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                textField.placeholder = "Name"
            })
            alert.textFields?.first?.text = item.title
            alert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                textField.placeholder = "Calories"
                textField.text = item.caloriesPlanned
            })
             alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                           guard let field = alert.textFields?[0], let newTitle = field.text, let calField = alert.textFields?[1], let newCalText = calField.text, !newTitle.isEmpty else{
                               return
                           }
                           self?.updateItem(item: item, newTitle: newTitle, newCaloriesPlanned: newCalText)
                       }))
            
            self.present(alert, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        
        present(sheet, animated: true)
        
    }
    
    let planTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(planTableView)
        planTableView.delegate = self
        planTableView.dataSource = self
        planTableView.frame = CGRect(x: 0, y: 340, width: 414, height: 450)
        self.planTableView.backgroundColor = UIColor.darkGray
        getAllItems()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        planView.layer.shouldRasterize = true
        planView.layer.rasterizationScale = UIScreen.main.scale
        planView.layer.cornerRadius = 15
    }
    
    @objc private func didTapAdd(totalCalRequired: Double) {
        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Name"
        })
        alert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
            textField.placeholder = "Calories"
        })
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?[0], let text = field.text, let calField = alert.textFields?[1], let calText = calField.text, !text.isEmpty else{
                return
            }
            self?.createItem(title: text, caloriesPlanned: calText)
        }))
        
        present(alert, animated: true)
        
    }
    
    func getAllItems(){
        do{
            modelsPlan = try context.fetch(UserInfo.fetchRequest())
            DispatchQueue.main.async {
                self.planTableView.reloadData()
            }
        } catch{
            //            error
        }
    }
    
    func createItem(title: String, caloriesPlanned: String){
        let newItem = UserInfo(context: context)
        newItem.title = title
        newItem.caloriesPlanned = caloriesPlanned
        
        do {
            try context.save()
            getAllItems()
        }catch{
            //            error
        }
    }
    
    func deleteItem(item: UserInfo){
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        }catch{
            //            error
        }
    }
    
    func updateItem(item: UserInfo, newTitle: String, newCaloriesPlanned: String){
        item.title = newTitle
        item.caloriesPlanned = newCaloriesPlanned
        
        do {
            try context.save()
            getAllItems()
        }catch{
            //            error
        }
    }
    
}








////
////  CustomPicker.swift
////  matchtracker
////
////  Created by Brendan Lensink on 2017-04-15.
////  Copyright © 2017 blensink. All rights reserved.
////
//
//import UIKit
//
//enum PickerType {
//    case format
//    case rel
//}
//
//class CustomPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
//    
//    var type: PickerType?
//    
//
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        guard let type = self.type else { return 0 }
//        
//        switch type {
//        case PickerType.format: return formats.count
//        case PickerType.rel: return rels.count
//        }
//    }
//    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
//        
//        var label = view as! UILabel!
//        if label == nil {
//            label = UILabel()
//        }
//        
//        label?.font = UIFont.systemFont(ofSize: 24)
//        label?.textColor = Color.Text.main
//        label?.textAlignment = .center
//        
//        guard let type = self.type else { return UIView() }
//        
//        switch type {
//        case PickerType.format: label?.text = formats[row]
//        case PickerType.rel: label?.text = rels[row]
//        }
//
//        return label!
//        
//    }
//}

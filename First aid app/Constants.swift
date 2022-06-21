//
//  Constants.swift
//  First aid app
//
//  Created by Jan Paleń on 13/05/2022.
//

struct K {
    static let appName = "PKM"
    static let medsCellIdentifier = "MedicationsCell"
    static let medsCellNibName = "MedicinesCell"
    
    static let pressureCellIdentifier = "ReusePressureCell"
    static let pressureCellNibName = "PressureCell"
    
    static let sugarCellIdentifier = "ReuseSugarCell"
    static let sugarCellNibName = "SugarCell"
    
    struct FStore {
        
        static let medsCollectionName = "medicines"
        static let frequencyField = "frequency"
        static let portionsField = "portions"
        
        static let dateField = "date"
        static let nameField = "name"
        static let stringDate = "string date"
        
        static let pressureCollectionName = "pressure"
        static let pulseField = "pulse"
        static let systolicPressureField = "systolic pressure"
        static let diastolicPressureField = "diastolic pressure"
        
        static let sugarCollectionName = "sugar"
        static let sugarLevelField = "sugar level"
        
    }
}

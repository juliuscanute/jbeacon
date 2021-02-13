//
//  TestHostController.swift
//  IBeaconTest.swift
//
//  Created by Julius Canute on 7/2/21.
//
import Foundation
@testable import jbeacon
@testable import Bluetooth
@testable import CLIKit

class MockBluetoothImplementation : AdvertisementInterface {
    func setAdvertisingParameters() {
        
    }
    
    func setAdvertisingData(payload: LowEnergyAdvertisingData.ByteValue) {
        
    }
    
    func turnOffAdvertising() {
        
    }
    
    func turnOnAdvertising() {
        
    }
}

//
//  BluetoothImplementation.swift
//  jbeacon
//
//  Created by Julius Canute on 13/2/21.
//

import Foundation
import Bluetooth
import BluetoothDarwin


class BluetoothImplementation: HostInterface {
    let controller = HostController.default!
    func setAdvertisingParameters() throws {
        try controller.setAdvertisingParameters()
    }
    
    func setAdvertisingData(payload: LowEnergyAdvertisingData.ByteValue) throws {
        try controller.setAdvertisingData(payload: payload)
    }
    
    func turnOffAdvertising() throws {
        try controller.turnOffAdvertising()
    }
    
    func turnOnAdvertising() throws {
        try controller.turnOnAdvertising()
    }
}

extension BluetoothHostControllerInterface {
    func setAdvertisingParameters() throws {
        let interval = AdvertisingInterval(rawValue: 100)!
        let advertisingParameters = HCILESetAdvertisingParameters(interval: (min: interval, max: interval))
        try deviceRequest(advertisingParameters, timeout: HCICommandTimeout.default)
    }
    
    func setAdvertisingData(payload: LowEnergyAdvertisingData.ByteValue) throws {
        let advertisingDataCommand = HCILESetAdvertisingData(advertisingData: LowEnergyAdvertisingData(length: 31, bytes: payload))
        try deviceRequest(advertisingDataCommand, timeout: HCICommandTimeout.default)
    }
    
    func turnOffAdvertising() throws {
        do {
            try enableLowEnergyAdvertising(false, timeout: HCICommandTimeout.default)
        } catch  {}
    }
    
    func turnOnAdvertising()throws {
        do {
            try enableLowEnergyAdvertising(timeout: HCICommandTimeout.default)
        } catch  {}
    }
}




//
//  HostInterface.swift
//  jbeacon
//
//  Created by Julius Canute on 13/2/21.
//

import Foundation
import Bluetooth
import BluetoothDarwin

protocol AdvertisementInterface {
    func setAdvertisingParameters() throws
    func setAdvertisingData(payload: LowEnergyAdvertisingData.ByteValue) throws
    func turnOffAdvertising() throws
    func turnOnAdvertising() throws
}

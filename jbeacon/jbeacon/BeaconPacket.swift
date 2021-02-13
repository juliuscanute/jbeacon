//
//  BeaconCommand.swift
//  jbeacon
//
//  Created by Julius Canute on 13/2/21.
//

import Foundation
import Bluetooth
import BluetoothDarwin

class BeaconPacket {
    let controller: AdvertisementInterface
    init(controller: AdvertisementInterface) {
        self.controller = controller
    }
    
    func broadcast(verbose: Bool, uuid: String, manufacturer: UInt16, major: UInt16, minor: UInt16, measuredPower: UInt8) throws {
        let manufacturerBytes = withUnsafeBytes(of: manufacturer.bigEndian, Array.init)
        let uuidCommand = UUID(uuidString: uuid)!.bytes
        let majorBytes = withUnsafeBytes(of: major.bigEndian, Array.init)
        let minorBytes = withUnsafeBytes(of: minor.bigEndian, Array.init)
        let txCommand: UInt8 = measuredPower
        let postfix: UInt8 = 0x00
        let payload: LowEnergyAdvertisingData.ByteValue = (UInt8(0x02), UInt8(0x01), UInt8(0x1a), UInt8(0x1a), UInt8(0xff), UInt8(manufacturerBytes[1]) , UInt8(manufacturerBytes[0]), UInt8(0x02), UInt8(0x15), uuidCommand.0,uuidCommand.1,uuidCommand.2,uuidCommand.3,uuidCommand.4,uuidCommand.5,uuidCommand.6,uuidCommand.7,uuidCommand.8,uuidCommand.9,uuidCommand.10,uuidCommand.11,uuidCommand.12,uuidCommand.13,uuidCommand.14,uuidCommand.15, UInt8(majorBytes[0]), UInt8(majorBytes[1]), UInt8(minorBytes[0]), UInt8(minorBytes[1]), txCommand, postfix)
        try controller.turnOffAdvertising()
        log(verbose: verbose, text:"Advertising OFF".yellow())
        try controller.setAdvertisingParameters()
        log(verbose: verbose, text:"Advertisement parameters set".yellow())
        try controller.turnOnAdvertising()
        log(verbose: verbose, text:"Advertising ON".yellow())
        try controller.setAdvertisingData(payload: payload)
        log(verbose: verbose, text:"Advertisement data set".yellow())
        log(verbose: true, text: "Using uuid:\(uuid) manufacturer:\(manufacturer) major:\(major) minor:\(minor) tx:\(measuredPower)".bold().blue())
    }
    
    func stopBeacon() throws {
        try controller.turnOffAdvertising()
    }
    
    func log(verbose: Bool, text: String) {
        if(verbose) {
            print(text)
        }
    }
}

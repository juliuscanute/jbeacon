//
//  main.swift
//  jbeacon
//
//  Created by Julius Canute on 7/2/21.
//

import Foundation
import Bluetooth
import BluetoothDarwin

let currentVersionDescription: String = "jbeacon 0.2.0"
let defaults = UserDefaults.standard

let uuid: UUID
if let uuidString = defaults.string(forKey: "uuid") {
    if let result = UUID(uuidString: uuidString) {
        uuid = result
    }
    else {
        fputs("UUID init FAILED", stderr)
        exit(1)
    }
}
else {
    uuid = UUID()
}
let manufacturer: UInt16 = UInt16(UserDefaults.standard.integer(forKey: "manufacturer"))
let major: UInt16 = UInt16(UserDefaults.standard.integer(forKey: "major"))
let minor: UInt16 = UInt16(UserDefaults.standard.integer(forKey: "minor"))
let measuredPower: UInt8 = UInt8(UserDefaults.standard.integer(forKey: "measuredPower"))

let controller = HostController.default!

let prefix: [UInt8] = [0x02, 0x01, 0x1a, 0x1a, 0xff]
let manufacturerBytes = withUnsafeBytes(of: manufacturer.bigEndian, Array.init)
let uuidCommand = uuid.bytes
let majorBytes = withUnsafeBytes(of: major.bigEndian, Array.init)
let minorBytes = withUnsafeBytes(of: minor.bigEndian, Array.init)
let txCommand: UInt8 = measuredPower
let postfix: UInt8 = 0x00

let payload: LowEnergyAdvertisingData.ByteValue = (UInt8(0x02), UInt8(0x01), UInt8(0x1a), UInt8(0x1a), UInt8(0xff), UInt8(manufacturerBytes[1]) , UInt8(manufacturerBytes[0]), UInt8(0x02), UInt8(0x15), uuidCommand.0,uuidCommand.1,uuidCommand.2,uuidCommand.3,uuidCommand.4,uuidCommand.5,uuidCommand.6,uuidCommand.7,uuidCommand.8,uuidCommand.9,uuidCommand.10,uuidCommand.11,uuidCommand.12,uuidCommand.13,uuidCommand.14,uuidCommand.15, UInt8(majorBytes[0]), UInt8(majorBytes[1]), UInt8(minorBytes[0]), UInt8(minorBytes[1]), txCommand, postfix)

let interval = AdvertisingInterval(rawValue: 100)!

do { try controller.enableLowEnergyAdvertising(false, timeout: HCICommandTimeout.default) } catch HCIError.commandDisallowed {
    print("turned off before")
}

let advertisingParameters = HCILESetAdvertisingParameters(interval: (min: interval, max: interval))

try controller.deviceRequest(advertisingParameters, timeout: HCICommandTimeout.default)

do { try controller.enableLowEnergyAdvertising(timeout: HCICommandTimeout.default) } catch HCIError.commandDisallowed {
    print("turned on before")
}

let advertisingDataCommand = HCILESetAdvertisingData(advertisingData: LowEnergyAdvertisingData(length: 31, bytes: payload))

try controller.deviceRequest(advertisingDataCommand, timeout: HCICommandTimeout.default)

RunLoop.main.run()

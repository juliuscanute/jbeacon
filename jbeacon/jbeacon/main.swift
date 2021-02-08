//
//  main.swift
//  jbeacon
//
//  Created by Julius Canute on 7/2/21.
//

import Foundation
import Bluetooth
import BluetoothDarwin
import CLIKit
import ColorizeSwift

class BeaconCommand: Command {
    
    let description = "jbeacon - Broadcast beacon"
    let controller = HostController.default!
    
    @CommandOption(short: "uuid", default: UUID().uuidString, description: "Specify UUID to Broadcast")
    var uuid: String
    
    @CommandOption(short: "manufacturer", default: 0, description: "Specify Manufacturer")
    var manufacturer: UInt16
    
    @CommandOption(short: "major", default: 0, description: "Specify Major")
    var major: UInt16
    
    @CommandOption(short: "minor", default: 0, description: "Specify Minor")
    var minor: UInt16
    
    @CommandOption(short: "measuredPower", default: 128, description: "Specify Measured Power")
    var measuredPower: UInt8
    
    func run() {
        broadcast(uuid: uuid, manufacturer: manufacturer, major: major, minor: minor, measuredPower: measuredPower)
        print("Broadcast Started 📶".green().bold())
        
    }
    
    func setAdvertisingParameters() {
        let interval = AdvertisingInterval(rawValue: 100)!
        let advertisingParameters = HCILESetAdvertisingParameters(interval: (min: interval, max: interval))
        
        do {
            try controller.deviceRequest(advertisingParameters, timeout: HCICommandTimeout.default)
            print("Setting advertisement parameters".yellow())
        } catch {
            print("Is your Bluetooth On".red())
        }
        
    }
    
    func setAdvertisingData(payload: LowEnergyAdvertisingData.ByteValue) {
        let advertisingDataCommand = HCILESetAdvertisingData(advertisingData: LowEnergyAdvertisingData(length: 31, bytes: payload))
        
        do {
            try controller.deviceRequest(advertisingDataCommand, timeout: HCICommandTimeout.default)
            print("Setting advertisement data".yellow())
        } catch {
            print("Is your Bluetooth On".red())
        }
    }
    
    func turnOffAdvertising() {
        do {
            try controller.enableLowEnergyAdvertising(false, timeout: HCICommandTimeout.default)
        } catch  {}
        print("Turning off advertising".yellow())
    }
    
    
    func turnOnAdvertising() {
        do { try controller.enableLowEnergyAdvertising(timeout: HCICommandTimeout.default) } catch  {}
        print("Turning on advertising".yellow())
    }
    
    func broadcast(uuid: String, manufacturer: UInt16, major: UInt16, minor: UInt16, measuredPower: UInt8) {
        print("Using uuid:\(uuid) manufacturer:\(manufacturer) major:\(major) minor:\(minor) tx:\(measuredPower)".bold().blue())
        let manufacturerBytes = withUnsafeBytes(of: manufacturer.bigEndian, Array.init)
        let uuidCommand = UUID(uuidString: uuid)!.bytes
        let majorBytes = withUnsafeBytes(of: major.bigEndian, Array.init)
        let minorBytes = withUnsafeBytes(of: minor.bigEndian, Array.init)
        let txCommand: UInt8 = measuredPower
        let postfix: UInt8 = 0x00
        let payload: LowEnergyAdvertisingData.ByteValue = (UInt8(0x02), UInt8(0x01), UInt8(0x1a), UInt8(0x1a), UInt8(0xff), UInt8(manufacturerBytes[1]) , UInt8(manufacturerBytes[0]), UInt8(0x02), UInt8(0x15), uuidCommand.0,uuidCommand.1,uuidCommand.2,uuidCommand.3,uuidCommand.4,uuidCommand.5,uuidCommand.6,uuidCommand.7,uuidCommand.8,uuidCommand.9,uuidCommand.10,uuidCommand.11,uuidCommand.12,uuidCommand.13,uuidCommand.14,uuidCommand.15, UInt8(majorBytes[0]), UInt8(majorBytes[1]), UInt8(minorBytes[0]), UInt8(minorBytes[1]), txCommand, postfix)
        turnOffAdvertising()
        setAdvertisingParameters()
        turnOnAdvertising()
        setAdvertisingData(payload: payload)
    }
    
}

let beacon = BeaconCommand()
let command = try CommandLineParser().parse(command: beacon)
try command.run()


Execution.runUntilTerminated { signal in
    switch signal {
    case .terminate:
        beacon.turnOffAdvertising()
        exit(0)
    case .interrupt:
        beacon.turnOffAdvertising()
        exit(0)
    case .terminalDisconnected:
        beacon.turnOffAdvertising()
        return false
    }
}

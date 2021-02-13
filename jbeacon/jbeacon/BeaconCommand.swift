//
//  BeaconCommand.swift
//  jbeacon
//
//  Created by Julius Canute on 9/2/21.
//

import Foundation
import Bluetooth
import BluetoothDarwin
import CLIKit
import ColorizeSwift

class BeaconCommand: Command {
    let description = "Beacon Editor CLI - v1.2.1"
    static let uuidRegex = #"\b[0-9a-f]{8}\b-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-\b[0-9a-f]{12}\b"#
    static let uint16Regex = #"^(-?(\d{1,4}|[012]\d{4}|3[01]\d{3}|32[0123456]\d{2}|327[012345]\d{1}|3276[01234567])|-32768)"#
    static let uint8Regex = #"\b(1?[0-9]{1,2}|2[0-4][0-9]|25[0-5])\b"#
    let beaconCommand: BeaconPacket
    init(controller: AdvertisementInterface) {
        self.beaconCommand = BeaconPacket(controller: controller)
    }
    
    @CommandFlag(name: "help", short: "h", description: "Prints usage instructions")
    var help: Bool
    
    @CommandFlag(name: "verbose", short: "v", description: "Prints verbose output")
    var verbose: Bool
    
    @CommandOption(short: "uuid", default: UUID().uuidString, regex: uuidRegex, description: "Specify UUID to Broadcast")
    var uuid: String
    
    @CommandOption(short: "manufacturer", default: 0, regex: uint16Regex, description: "Specify Manufacturer")
    var manufacturer: UInt16
    
    @CommandOption(short: "major", default: 0, regex: uint16Regex, description: "Specify Major")
    var major: UInt16
    
    @CommandOption(short: "minor", default: 0, regex: uint16Regex, description: "Specify Minor")
    var minor: UInt16
    
    @CommandOption(short: "measuredPower",  default: 128, regex: uint8Regex, description: "Specify Measured Power")
    var measuredPower: UInt8
    
    func run() throws {
        try beaconCommand.broadcast(verbose: verbose, uuid: uuid, manufacturer: manufacturer, major: major, minor: minor, measuredPower: measuredPower)
        print("Broadcast Started 📶".green().bold())
    }
    
    func stop() {
        do {
            try beaconCommand.stopBeacon()
        } catch { }
    }
}

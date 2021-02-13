//
//  main.swift
//  jbeacon
//
//  Created by Julius Canute on 7/2/21.
//
import CLIKit
import Bluetooth
import BluetoothDarwin

let beacon = BroadcastArguments(controller: BluetoothImplementation())
do {
    let command = try CommandLineParser().parse(command: beacon)
    try command.run()
    Execution.runUntilTerminated(signalHandler: {_ in
        beacon.stop()
        return true
    })
} catch CommandLineError.invalidArgumentValueFormat(let captured) {
    print("Invalid arguments supplied: \(captured)".red())
    beacon.printUsage()
} catch CommandLineError.usageRequested( _) {
    beacon.printUsage()
} catch {
    print("Unable to complete broadcast request:".red())
    print("Verify bluetooth device is turned on & try again.".red())
}

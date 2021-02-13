//
//  main.swift
//  jbeacon
//
//  Created by Julius Canute on 7/2/21.
//
import CLIKit
import Bluetooth
import BluetoothDarwin

let beacon = BeaconCommand(controller: HostAdvertisementImplementation())
do {
    let command = try CommandLineParser().parse(command: beacon)
    try command.run()
    Execution.runUntilTerminated(signalHandler: {_ in
        beacon.stop()
        return true
    })
}catch {
    if(error is CommandLineError){
        print(error.localizedDescription)
    }else {
        print("Unable to complete broadcast request:".red())
        print("Verify bluetooth device is turned on & try again.".red())
    }
}

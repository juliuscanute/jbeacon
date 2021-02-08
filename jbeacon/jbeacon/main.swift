//
//  main.swift
//  jbeacon
//
//  Created by Julius Canute on 7/2/21.
//
import CLIKit

let beacon = BeaconCommand()
let command = try CommandLineParser().parse(command: beacon)
try command.run()


Execution.runUntilTerminated(signalHandler: {_ in
    beacon.turnOffAdvertising()
    return true
})

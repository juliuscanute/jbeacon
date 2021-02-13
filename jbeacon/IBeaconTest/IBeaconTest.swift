//
//  IBeaconTest.swift
//  IBeaconTest
//
//  Created by Julius Canute on 12/2/21.
//

import XCTest
@testable import jbeacon
@testable import CLIKit
class IBeaconTest: XCTestCase {
    
    func testValidUUID() throws {
        let beacon = BroadcastArguments(controller: MockBluetoothImplementation())
        let parser = CommandLineParser()
        let arguments: [String] = [
            "jbeacon",
            "-uuid",
            "045af837-e309-4e62-8206-41c41ebeac02",
        ]
        let parsedCommand = try parser.parseArguments(arguments, command: beacon, expectedRootCommand: "jbeacon")
        let command = parsedCommand
        try command.run()
    }
    
    func testInValidUUID() throws {
        let beacon = BroadcastArguments(controller: MockBluetoothImplementation())
        let parser = CommandLineParser()
        let arguments: [String] = [
            "jbeacon",
            "-uuid",
            "045af837-e309-4e62-8206-41c41ebeac",
        ]
        func testInValidUUIDThrow() throws {
            let parsedCommand = try parser.parseArguments(arguments, command: beacon, expectedRootCommand: "jbeacon")
            let command = parsedCommand
            try command.run()
        }
        XCTAssertThrowsError(try testInValidUUIDThrow())
    }
    
    func testValidManufacturer() throws {
        let beacon = BroadcastArguments(controller: MockBluetoothImplementation())
        let parser = CommandLineParser()
        let arguments: [String] = [
            "jbeacon",
            "-manufacturer",
            "65535",
        ]
        let parsedCommand = try parser.parseArguments(arguments, command: beacon, expectedRootCommand: "jbeacon")
        let command = parsedCommand
        try command.run()
    }
    
    func testInvalid16ByteData() throws {
        func testInValidDataThrow(data: Int) throws {
            let beacon = BroadcastArguments(controller: MockBluetoothImplementation())
            let parser = CommandLineParser()
            let arguments: [String] = [
                "jbeacon",
                "-manufacturer",
                "\(data)",
                "-major",
                "\(data)",
                "-minor",
                "\(data)"
            ]
            let parsedCommand = try parser.parseArguments(arguments, command: beacon, expectedRootCommand: "jbeacon")
            let command = parsedCommand
            try command.run()
        }
        
        XCTAssertThrowsError(try testInValidDataThrow(data: -1))
        XCTAssertThrowsError(try testInValidDataThrow(data: 65536))
    }
    
    
    func testValidMajorAndMinor() throws {
        let beacon = BroadcastArguments(controller: MockBluetoothImplementation())
        let parser = CommandLineParser()
        let arguments: [String] = [
            "jbeacon",
            "-major",
            "65535",
            "-minor",
            "0",
        ]
        let parsedCommand = try parser.parseArguments(arguments, command: beacon, expectedRootCommand: "jbeacon")
        let command = parsedCommand
        try command.run()
    }
    
    func testMeasuredPower() throws {
        let beacon = BroadcastArguments(controller: MockBluetoothImplementation())
        let parser = CommandLineParser()
        let arguments: [String] = [
            "jbeacon",
            "-measuredPower",
            "255"
        ]
        let parsedCommand = try parser.parseArguments(arguments, command: beacon, expectedRootCommand: "jbeacon")
        let command = parsedCommand
        try command.run()
    }
    
    func testInvalidMeasuredPower() throws {
        func testInValidDataThrow(data: Int) throws {
            let beacon = BroadcastArguments(controller: MockBluetoothImplementation())
            let parser = CommandLineParser()
            let arguments: [String] = [
                "jbeacon",
                "-measuredPower",
                "\(data)"
            ]
            let parsedCommand = try parser.parseArguments(arguments, command: beacon, expectedRootCommand: "jbeacon")
            let command = parsedCommand
            try command.run()
        }
        
        XCTAssertThrowsError(try testInValidDataThrow(data: -1))
        XCTAssertThrowsError(try testInValidDataThrow(data: 256))
    }
    
}

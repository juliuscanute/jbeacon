![Swift](https://github.com/juliuscanute/jbeacon/workflows/Swift/badge.svg)
# jbeacon
iBeacon Editor CLI

# Installation
```sh
brew tap juliuscanute/formulae
brew install jbeacon
```

# Description
```sh
OVERVIEW: Beacon Editor CLI - v1.2.1

USAGE: jbeacon

FLAGS:
  -h, --help              Displays help text.
  -h, --help              Prints usage instructions
  -v, --verbose           Prints verbose output

OPTIONS:
  -major, --major <value> Specify Major Defaults to "0".
  -manufacturer, --manufacturer <value>
                          Specify Manufacturer Defaults to "0".
  -measuredPower, --measuredPower <value>
                          Specify Measured Power Defaults to "128".
  -minor, --minor <value> Specify Minor Defaults to "0".
  -uuid, --uuid <value>   Specify UUID to Broadcast Defaults to "D7C707AB-9E46-499D-9CB4-C73E15C94E6F"
```

# Usage set UUID
```sh
$ jbeacon -uuid efb8454c-6988-11eb-9439-0242ac130002
Using uuid:efb8454c-6988-11eb-9439-0242ac130002 manufacturer:0 major:0 minor:0 tx:128
Broadcast Started 📶
```

# Usage set UUID & manufacturer
```sh
$ jbeacon -uuid efb8454c-6988-11eb-9439-0242ac130002 -manufacturer 1234
Using uuid:efb8454c-6988-11eb-9439-0242ac130002 manufacturer:1234 major:0 minor:0 tx:128
Broadcast Started 📶
```

# Usage set UUID, manufacturer, major, minor & measuredPower(tx)
```sh
$ jbeacon -uuid efb8454c-6988-11eb-9439-0242ac130002 -manufacturer 1234 -major 1 -minor 2 -measuredPower 128
Using uuid:efb8454c-6988-11eb-9439-0242ac130002 manufacturer:1234 major:1 minor:2 tx:128
Broadcast Started 📶
```

# Credits
1. https://github.com/PureSwift/BluetoothDarwin
2. https://github.com/PureSwift/Bluetooth
3. https://github.com/watr/mbeacon
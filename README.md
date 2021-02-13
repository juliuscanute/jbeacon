![Swift](https://github.com/juliuscanute/jbeacon/workflows/Swift/badge.svg)
# jbeacon
iBeacon Editor CLI

# Installation
```sh
brew tap juliuscanute/formulae
brew install jbeacon
```


# Usage
```sh
jbeacon -uuid efb8454c-6988-11eb-9439-0242ac130002
jbeacon -uuid efb8454c-6988-11eb-9439-0242ac130002 -manufacturer 1234
jbeacon -uuid efb8454c-6988-11eb-9439-0242ac130002 -manufacturer 1234 -major 1 -minor 2 -measuredPower 128
```

# Credits
1. https://github.com/PureSwift/BluetoothDarwin
2. https://github.com/PureSwift/Bluetooth
3. https://github.com/watr/mbeacon
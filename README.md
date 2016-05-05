# BreweryDB
[![Build Status](https://travis-ci.org/jwelton/BreweryDB.svg)](https://travis-ci.org/jwelton/BreweryDB)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

A Swift library for communicating with the BreweryDB api (v2). This library simplifies the task of sending and receiving data between your app and the BreweryDB server. It has been developed using Swift 2 and uses a simply block interface for maximum readability. This framework is heavily unit tested to provide a stable library. If you find any issues or have any requests, please open an issue :smiley:

## Installation
Currently there is only one support method of installation, which is via Carthage (although manual installation is also possible, instructions for doing so will not be listed here). Please see below for a basic overview of installing via Carthage.

#### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. Full instructions for integrating frameworks using Carthage are avaliable within the readme.md on their [GitHub Repository](https://github.com/Carthage/Carthage).

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:
```
$ brew update
$ brew install carthage
```
To integrate Alamofire into your Xcode project using Carthage, specify it in your Cartfile:
```
github "jwelton/BreweryDB" ~> 1.0
```
Run carthage update to build the framework and drag the built BreweryDB.framework into your Xcode project. (you also need to add a custom run script too, please see the Carthage instructions for details on this)

## Usage
This interface within this library is designed to be simple and easy to use. Below are examples of how to request beers and breweries using this service.

Before attempting any requests, you need to set your API key (you will need to register on the [BreweryDB](https://www.brewerydb.com/) website to get this). You only need to set this once and its done as follows:

``` swift
BreweryDBApiKey = "MyKeyHere"
```

We recommend setting this in the AppDelegate, so it has always been called before any request might take place.

#### Beer
###### Request
``` swift
let request = BeerRequest(requestParams: [.Abv: "5"])
request?.loadBeersWithCompletionHandler() { beers in
  /// Access your array of beers here (or nil if nothing was found)
}
```

###### Request With Ordering
``` swift
let request = BeerRequest(requestParams: [.Abv: "5"], orderBy: .Name)
request?.loadBeersWithCompletionHandler() { beers in
  /// Access your array of beers here (or nil if nothing was found)
}
```

###### Parameters
``` swift
public enum BeerRequestParam: String {
  case Identifier = "ids"
  case Name = "name"
  case Abv = "abv"
  case Ibu = "ibu"
  case IsOrganic = "isOrganic"
  case HasLabels = "hasLabels"
  case Since = "since"
  case Status = "status"
  case RandomCount = "order"
}
```

#### Brewery
###### Request
``` swift
let request = BreweryRequest(requestParams: [.Name: "Brewery"])
request?.loadBreweriesWithCompletionHandler() { breweries in
  /// Access your array of breweries here (or nil if nothing was found)
}
```

###### Request With Ordering
``` swift
let request = BreweryRequest(requestParams: [.Name: "Brewery"], orderBy: .Name)
request?.loadBreweriesWithCompletionHandler() { breweries in
  /// Access your array of breweries here (or nil if nothing was found)
}
```

###### Parameters
``` swift
public enum BreweryRequestParam: String {
  case Identifier = "ids"
  case Name = "name"
  case Abv = "abv"
  case Ibu = "ibu"
  case GlasswareId = "glasswareId"
  case SrmId = "srmId"
  case AvaliableId = "availableId"
  case StyleId = "styleId"
  case IsOrganic = "isOrganic"
  case HasLabels = "hasLabels"
  case Year = "year"
  case Since = "since"
  case Status = "status"
  case RandomCount = "order"
}
```

## Contributing
Contributing is easy, simply decide on a bug you want to fix or feature you want to implement (or preferably pick one from the issues list) then follow the instructions below:

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## Credits
This BreweryDB library is owned and maintained by [Jake Welton](http://jakewelton.co.uk).

## License
This library is released under the MIT license. See LICENSE for details.

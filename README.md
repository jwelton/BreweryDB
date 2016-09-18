BreweryDB

[![Build Status](https://travis-ci.org/jwelton/BreweryDB.svg)](https://travis-ci.org/jwelton/BreweryDB)
![Test Coverage](https://img.shields.io/badge/coverage-70.86%25-green.svg)
![](https://img.shields.io/badge/language-Swift%203-brightgreen.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/jwelton/BreweryDB/master/LICENSE)


An iOS Swift library for communicating with the BreweryDB api (v2). This library simplifies the task of sending and receiving data between your app and the BreweryDB server. This library is able to construct correct BreweryDB URL's, perform the network request and then serialise the response JSON into objects ready for use in your app.

## Installation

#### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. Full instructions for integrating frameworks using Carthage are avaliable within the readme.md on their [GitHub Repository](https://github.com/Carthage/Carthage).

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:
```
$ brew update
$ brew install carthage
```
To integrate BreweryDB into your Xcode project using Carthage, specify it in your Cartfile:
```
github "jwelton/BreweryDB"
```
Run carthage update to build the framework and drag the built BreweryDB.framework into your Xcode project. (you also need to add a custom run script too, please see the Carthage instructions for details on this)

## Usage
The interface within this library is designed to be simple and easy to use. Below are examples of how to request beers and breweries using this service.

Before attempting any requests, you need to set your API key (you will need to register on the [BreweryDB](https://www.brewerydb.com/) website to get this). You only need to set this once and its done as follows:

``` swift
breweryDBApiKey = "MyKeyHere"
```

We recommend setting this in the AppDelegate, so it has always been called before any request might take place.

#### Beer
###### Request
``` swift
let beerRequest = BeerRequest(params: [.identifier: "cBLTUw"])
let requestMan = RequestManager<Beer>(request: beerRequest)
    
requestMan?.fetch() { beers in
    /// Access your array of beers here (or nil if nothing was found)
}
```

###### Request With Ordering
``` swift
let beerRequest = BeerRequest(params: [.identifier: "cBLTUw"], orderBy: .name)
let requestMan = RequestManager<Beer>(request: beerRequest)
    
requestMan?.fetch() { beers in
    /// Access your array of beers here (or nil if nothing was found)
}
```

###### Parameters
``` swift
public enum BeerRequestParam: String {
	case identifier
	case name
	case abv
	case ibu
	case isOrganic
	case hasLabels
	case since
	case status
	case randomCount
	case pageNumber
	case styleId
	case withBreweries
}
```

###### Order Parameters
``` swift
public enum BeerRequestOrderParam : String {
	case name
	case description
	case abv
	case ibu
	case isOrganic
	case status
	case createDate
	case updateDate
	case random
}
```

#### Brewery
###### Request
``` swift
let breweryRequest = BreweryRequest(params: [.identifier: "YXDiJk"])
let requestMan = RequestManager<Beer>(request: breweryRequest)
    
requestMan?.fetch() { breweries in
    /// Access your array of breweries here (or nil if nothing was found)
}
```

###### Request With Ordering
``` swift
let breweryRequest = BreweryRequest(params: [.identifier: "YXDiJk"], orderBy: .name)
let requestMan = RequestManager<Beer>(request: breweryRequest)
    
requestMan?.fetch() { breweries in
    /// Access your array of breweries here (or nil if nothing was found)
}
```

###### Parameters
``` swift
public enum BreweryRequestParam: String {
	case identifier
	case name
	case abv
	case ibu
	case glasswareId
	case srmId
	case avaliableId
	case styleId
	case isOrganic
	case hasLabels
	case year
	case since
	case status
	case randomCount
	case pageNumber
}
```

###### Order Parameters
``` swift
public enum BreweryRequestOrderParam : String {
    case name
    case description
    case website
    case established
    case mailingListURL
    case isOrganic
    case status
    case createDate
    case updateDate
    case random
}
```

#### Search
###### Request
``` swift
let searchRequest = SearchRequest(params: [.searchTerm: "Dead Pony", .resultType: "beer", .withBreweries: "Y"])
let requestMan = RequestManager<Search>(request: searchRequest)
    
requestMan?.fetch() { results in
    /// Access your array of results here (or nil if nothing was found)
}
```

###### Parameters
``` swift
public enum SearchRequestParam : String {
	case searchTerm
	case resultType
	case pageNumber
	case withBreweries
}
```

#### Other Request Types
Other request types (which work in the same way as above) include:

- Glass Request
- Style Request
- Category Request

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

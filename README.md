# rGBAT-html
* This repo provides some html and scripts to allow bulk upload and processing of addresses with NYC's powerful [Geosupport](https://www.nyc.gov/site/planning/data-maps/open-data/dwn-gde-home.page) geocoding software.
* Geosupport is powerful but complex. These scripts let a normal person upload a basic csv with an address and a zip code column to a web page and get back geocoded XY coordinates.

## Installation
* Currently this is set up to run on DOHMH servers (using our rGBAT package). But it will run with generic Linux and R and Apache.
* To do that, first install the rGBATl package, and the other packages and Geosupport software it requires. (See: https://github.com/torreyma/rGBATl)
* Then edit process.r to change it work with rGBATl instead of rGBAT (really, it's pretty easy.)
* You have to copy the files into the location your webserver serves pages from. So edit `deploy.sh` so all the files are going from-to the right places.
* Then just run it with sudo: `sudo deploy.sh`

## Usage
* Web browse to where upload.html is being served by your web server.
* Select your data csv file for upload.
* Select the column from the drop-down menu that contains your Addresses
* **You have to have zip codes in a separate column and that column has to be named ZIP_CODE**
    * (I'll fix this so it's selectable eventually.)

## TODO
* Add selectable zip code column.
* Excel instead of csv
* Add other Geosupport field options
* Add support for split addresses? (geosupport can handle it)
* Add advanced address cleaning (rBES functions)

## License and credits
* The original package, rGBAT, was written by Gretchen Culp (https://github.com/gmculp), initially exclusively for use on DOHMH's RHEL R server. (rGBATl simply extends its use to generalized Linux for the public.)
* This package is released under an MIT license (see LICENSE file).
* Geosupport Desktop Edition™ copyrighted by the New York City Department of City Planning. This product is freely available to the public with no limitations. 




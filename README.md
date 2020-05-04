
# XMLJSON
A Swift command-line tool to easily convert XML format to JSON.

<p align="center">
<a href="https://github.com/apple/swift-package-manager">
<img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">
</a>
  <img src="https://img.shields.io/badge/language-swift5.2-f48041.svg?style=flat"/>
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg?style=flat"/>
  <a href="https://twitter.com/alihilal94">
  	<img src="https://img.shields.io/badge/contact-@alihilal94-blue.svg?style=flat" alt="Twitter: @alihilal94" />
  </a>
</p>

![demo](https://github.com/engali94/XMLJson/blob/master/assets/xmljsonDemo.gif)

### Requirements
- Good Mood

### Usage

```
$ xmljson -h
OVERVIEW: Convert XML Format to JSON Format.
USAGE: xmljson --dir <dir> [--files <files> ...] [--output <output>] [--verbose] [--all]

OPTIONS:
  -d, --dir <dir>         Absolute path to a directory containing the xml files.
  -f, --files <files>     XML files to be parsed.
  -o, --output <output>   [Optinal] JSON file(s) output directory.
  -v, --verbose           Show extra logging for debugging purposes.
  -a, --all               Convert all XML files present in the specifed directory.
  -h, --help              Show help information.
```




First specify where the xml files are located through `--dir` argument **(Manadatory)**
Then you can specify the files to be converted in through `--files` argument you can pass as much as you want 

```bash
$ xmljson -d ~/xml/files/dir - file1.xml filen.xml --verbose
```

If you want to convert all the XML files present in the directory, pass the `--dir` argument and `--all` flag only.

```bash
$ xmljson -d ~/xml/files/dir  --all 
```

if you would like to change the output directory pass it to `--output` .

```bash
$ xmljson -d ~/xml/files/dir  -o ~/path/to/output/dir --all 
```

### Sample
XML Input
```xml
?xml version="1.0" encoding="UTF-8"?>
<bookstore>
  <book category="cooking">
    <title lang="en">Everyday 1</title>
    <author>Giada De Laurentiis</author>
    <year>2005</year>
    <price>30.00</price>
  </book>
  <book category="web">
    <title lang="en">Learning XML</title>
    <author>Erik T. Ray</author>
    <year>2003</year>
    <price>39.95</price>
  </book>
</bookstore>
```

JSON Output
```json
[
  {
    "author" : "Giada De Laurentiis",
    "title" : {
      "lang" : "en",
      "text" : "Everyday 1"
    },
    "year" : "2005",
    "category" : "cooking",
    "price" : "30.00"
  },
  {
    "author" : "Erik T. Ray",
    "title" : {
      "lang" : "en",
      "text" : "Learning XML"
    },
    "year" : "2003",
    "category" : "web",
    "price" : "39.95"
  }
]
```
### Installation using [HomeBrew](https://brew.sh)
You can install xmljson using homebrew as follows:

```bash
$ brew tap engali94/formulae
$ brew install xmljson
```
### Installation using [Make](https://en.wikipedia.org/wiki/Make_%28software%29)
You can install xmljson using make as follows:

```bash
$ git clone https://github.com/engali94/XMLJson.git
$ cd XMLJson
$ make install
```

### Development
- `cd` into the repository
- run `swift package generate-xcodeproj` 
- Run the following command to try it out:

	```bash
	swift run XMLJson --help
	```

### License

XMLJson is released under the MIT license. See [LICENSE](https://github.com/engali94/XMLJson/blob/master/LICENSE) for more information.  

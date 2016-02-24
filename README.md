![][license-badge]

# hash
Plugin for [Oh My Fish][omf].

Computes string digests using various hashing algorithms.

## Install
```fish
$ omf install hash
```

## Usage
The `hash` function does just one simple thing: it takes an algorithm and a string, computes the string's hash with the given algorithm, and prints out the result. The string to digest can be provided either as an argument, or piped in from standard input:

```fish
# command line argument...
$ hash md5 "Hello World!"
# ...or piped
$ cat myfile.txt | hash md5
```

The available algorithms depend on what utilities you have installed on your system. If you have GNU coreutils installed, any of the algorithms that have an `<algorithm>sum` command will be available. On BSD, the core digest commands provide the `md5`, `sha1`, `sha256`, `sha512`, and `rmd160` algorithms. Finally, if OpenSSL is installed, any algorithm installed for OpenSSL will also be available. To see if a given algorithm is available, you can run

```fish
$ hash -q <algorithm>
```

## License
[MIT][mit] © [coderstephen][author] et [al][contributors]


[mit]:            http://opensource.org/licenses/MIT
[author]:         http://github.com/coderstephen
[contributors]:   https://github.com/oh-my-fish/plugin-hash/graphs/contributors
[omf]:            https://www.github.com/oh-my-fish/oh-my-fish
[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square

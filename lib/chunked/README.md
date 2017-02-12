# chunked

[![Build Status](https://travis-ci.org/unn4m3d/chunked.svg?branch=master)](https://travis-ci.org/unn4m3d/chunked)

Chunked files writer and reader (Can read, for example, S.T.A.L.K.E.R's all.spawn)

Chunked file usually consists of blocks like following:
`index:T size:T data:[size]`

In case of S.T.A.L.K.E.R.'s `all.spawn`, T will be UInt32

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  chunked:
    github: unn4m3d/chunked
```


## Usage


```crystal
require "chunked"

reader = Chunked::IndexedReader(UInt32).new("path/to/all.spawn")
reader.index_chunks!
reader.chunks #=> [0 => {size: 3, offset: 8, index: 0},1 => {size: 3, offset: 19, index: 1}, ...]
reader[0] #=> Bytes[1u8,2u8,3u8]
reader.info(0) #=> {size: 3, offset: 8, index: 0}
reader.close

# TODO : More examples
```


## Development

### TODO
- Documentation
- Examples

## Contributing

1. Fork it ( https://github.com/unn4m3d/chunked/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [unn4m3d](https://github.com/unn4m3d) - creator, maintainer

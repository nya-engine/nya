# nya

[![Build Status](https://travis-ci.org/nya-engine/nya.svg?branch=master)](https://travis-ci.org/nya-engine/nya)

NyaEngine : 3D Game Engine written in [crystal](https://crystal-lang.org/) \[**Work in progress**\]

Inspired by Unity3D and X-Ray Engine

# How to test

Install dependencies :

* OpenGL
* OpenAL (not used yet)
* SDL2
* Pango and Cairo (for fonts)
* Crystal (tested on 0.24.1)

On Gentoo, this can be done using `emerge -a dev-games/ode media-libs/libsdl2 media-libs/openal media-libs/mesa x11-libs/pango x11-libs/cairo dev-lang/crystal`

Then run engine test:

```sh
  git clone https://github.com/nya-engine/nya/
  cd nya
  crystal deps
  crystal spec
  crystal test.cr
```

# Todo list

* [ ] Update code to match modern version of Crystal
  * [ ] Refactor logging
* [ ] Move on to modern OpenGL
  * [ ] Move to [CrystalEdge](https://github.com/unn4m3d/crystaledge)-based matrix stack instead of deprecated OpenGL one
  * [ ] Cut out fixed pipeline stuff 
* [ ] Separate server (physics, events, etc.) and client (audio, video, input, etc.)
* [ ] Models
  * [ ] Materials
    * [ ] Support for MTL files
  * [ ] Textures
    * [x] PNG
    * [ ] TGA
    * [ ] DDS
    * [ ] BMP
    * [ ] Dynamic texture generation (works but quite buggy)
  * [x] Support for Wavefront OBJ
  * [ ] Support for more model formats
    * [ ] OGF (probably)
* [ ] Physics (ODE)
* [ ] Windows support (requires windows support in crystal)
* [ ] Modular video and audio drivers
  * [x] Video backends (still WIP) 
  * [ ] DirectX support (requires windows support)
* [ ] Audio
* [ ] Scripting
  * [ ] Automatic bindings
  * [ ] Language support
    * [ ] Lua
    * [ ] Ruby
* [ ] Specify version requirements for dependencies
* [ ] Packaging tool

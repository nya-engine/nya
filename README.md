# nya

[![Build Status](https://travis-ci.org/unn4m3d/nya_engine.svg?branch=master)](https://travis-ci.org/unn4m3d/nya_engine)

NyaEngine : 3D Game Engine written in [crystal](https://crystal-lang.org/) \[**Work in progress**\]

Inspired by Unity3D and X-Ray Engine

# How to test

Install dependencies :

* OpenGL
* OpenAL
* Open Dynamics Engine
* SDL2
* Pango and Cairo
* Crystal (tested on 0.24.1)

On Gentoo, this can be done using `emerge -a dev-games/ode media-libs/libsdl2 media-libs/openal media-libs/mesa x11-libs/pango x11-libs/cairo dev-lang/crystal`

Then run engine test:

```sh
  git clone https://github.com/unn4m3d/nya/
  cd nya
  crystal deps
  crystal spec
  crystal test.cr
```

# Todo list

* [ ] Separate server (physics, events, etc.) and client (audio, video, input, etc.)
* [ ] Models
  * [ ] Materials
    * [ ] Support for MTL files
  * [ ] Textures
    * [ ] PNG
    * [ ] TGA
    * [ ] DDS
    * [ ] BMP
  * [x] Support for Wavefront OBJ
  * [ ] Support for more model formats
    * [ ] OGF (probably)
* [ ] Physics (ODE)
* [ ] Windows support (requires windows support in crystal)
* [ ] Modular video and audio drivers
  * [ ] DirectX support (requires windows support)
* [ ] Audio
* [ ] Scripting
  * [ ] Automatic bindings
  * [ ] Language support
    * [ ] Lua
    * [ ] Ruby
* [ ] Specify version requirements for dependencies 

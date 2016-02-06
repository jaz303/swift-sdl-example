An workspace project for hacking on [`CSDL2.swift`](https://github.com/jaz303/CSDL2.swift) and [`SDL2.swift`](https://github.com/jaz303/SDL2.swift). It provides a test project and sets up a local checkout of the two libraries from your own Github account.

So far this is only tested on OS X but the long term goal is full cross-platform compatibility.

The build process is <del>pretty rickety</del> a disaster right now. There's gratuitious use of `install_name_tool` and no encapsulation between modules. I'm punting on this until the library is more mature; hopefully by then the Swift package manager will have made some headway in this area.

## Current Status

  - [x] open a window
  - [x] quit on window close
  - [x] basic surface support
  - [ ] surface blitting
  - [ ] use mouse/keyboard to control a sprite

## Usage

  - fork this repository, along with my `SDL2.swift`, `CSDL2.swift`, `Cairo.swift` and `Ccairo.swift` projects (optional step, if skipped use `jaz303` for `$MY_GITHUB_USER`)
  - `$ ./init $MY_GITHUB_USER`
  - `$ cd modules/CSDL2/support`
  - Update `Makefile` so that `SDL` points to SDL install root
  - Update `module.map` with correct paths to SDL headers
  - `$ make`
  - `$ cd ../../..`
  - `$ make`
  - Run the test program: `$ ./build/main`


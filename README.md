An workspace project for hacking on [`CSDL2.swift`](https://github.com/jaz303/CSDL2.swift) and [`SDL2.swift`](https://github.com/jaz303/SDL2.swift). It provides a test project and sets up a local checkout of the two libraries from your own Github account.

The build process is pretty rickety right now!

## Usage

  - fork this repository, along with my `SDL2.swift` and `CSDL2.swift` projects
  - `$ ./init $MY_GITHUB_USER`
  - `$ make`
  - `$ ./build/main`

If SDL is installed somewhere other than `/usr/local/lib` you must update `Makefile` as well as `module.map` in [`CSDL2.swift`](https://github.com/jaz303/CSDL2.swift).

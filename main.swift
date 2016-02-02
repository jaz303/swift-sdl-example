import SDL2_swift

Init()
let win = Window(title: "SDL Swift Demo")
let img = Images.load("guardian.jpg")!
let surface = win.surface
surface.blitSurface(img, x: 30, y: 30)
win.update()

Timers.setTimeout(1000, callback: {
	(foo: AnyObject?) -> Void in
		print("timeout!")
})

//Timers.delay(1000)

createWindowAndWait()
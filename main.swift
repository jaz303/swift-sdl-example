import SDL2_swift

SDL.start()

let win = Window(title: "SDL Swift Demo")
let img = Images.load("guardian.jpg")!
let surface = win.surface
surface.blitSurface(img, x: 30, y: 30)
win.update()

Timers.setTimeout(1000, callback: {
	(foo: AnyObject?) -> Void in
		print("timeout!")
})

var evt = Event()
while true {
	Events.wait(&evt)
	if evt.isWindow && evt.isWindowClose {
		break	
	} else if evt.isMouseMotion {
		print(evt.mouseMotionX, evt.mouseMotionY)
	} else if evt.isMouseButtonDown && evt.isLeftMouseButton {
		print("left mouse down!")
	}
}

SDL.quit()

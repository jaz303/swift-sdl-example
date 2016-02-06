import SDL2_swift
import Cairo_swift


SDL.start()

let targetFormat = PixelFormats.forFormat(PixelFormats.ARGB8888)

let win = Window(title: "SDL Swift Demo")
let img = Images
			.load("guardian.jpg")!
			.convertedToPixelFormat(targetFormat)

print("image format:", img.pixelFormat.name)

//

let s = Surface(width: 300, height: 200)
let cis = ImageSurface(data: s.pixels, width: s.width, height: s.height, stride: s.pitch)
let c = Context(surface: cis)

c.setSourceRed(0.0, green: 0.0, blue: 1.0)
c.clear()

c.beginPath()
c.setSourceRed(0.0, green: 1.0, blue: 0.0)
c.moveToX(200.0, Y: 100.0)
c.lineToX(10.0, Y: 10.0)
c.stroke()


//let surface = win.surface
//surface.blitSurface(img, x: 30, y: 30)
//win.update()

let r = win.renderer
r.setDrawColorRed(0, green:0, blue:0)
r.clear()
r.setDrawColorRed(255, green:0, blue:0)

let t = r.createStreamingTextureWidth(s.width, height: s.height)
t.copyFromSurface(s)

print("texture size", t.width, t.height)

r.fillRect(Rect(x: 10, y: 10, w: 200, h: 100))
r.drawRect(Rect(x: 5, y: 5, w: 210, h: 110))

r.drawPointX(500, y: 500)
r.drawLineX1(30, y1: 400, x2: 600, y2: 200)

r.copyTexture(t, sourceRect: Rect(x:0, y:0, w:300, h:200), destinationRect: Rect(x:400, y:200, w:300, h:200))

r.present()



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
		// print(evt.mouseMotionX, evt.mouseMotionY)
	} else if evt.isMouseButtonDown && evt.isLeftMouseButton {
		// print("left mouse down!")
	}
}

SDL.quit()

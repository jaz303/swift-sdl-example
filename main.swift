import spline

class Sketch : Sketch2D {
	var x: Double = 0

	init() {
		super.init(width: 300, height: 200)
	}

	override func loop(clock: Clock) {
		x = (x + 1) % 300
		clear(r: 0.0, g: 0.0, b: 1.0)
		stroke(r: 0.0, g: 1.0, b: 0.0)
		begin()
		moveTo(x: x, y: 100)
		lineTo(x: x+5, y: 100)
		stroke()
	}
}

Sketch().start()
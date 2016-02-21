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
		pushMatrix()
		translate(dx: x, dy: 0)
		moveTo(x: 0, y: 100)
		lineTo(x: 5, y: 100)
		popMatrix()
		stroke()
	}
}

Sketch().start()
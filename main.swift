import spline

class Sketch : Sketch2D {
	override func setup() {
		fps(1)
		size(width: 800, height: 600)
	}

	override func loop(clock: Clock) {
		print("update!")
	}
}

Sketch().start()
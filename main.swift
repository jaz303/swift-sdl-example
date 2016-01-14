import SDL2_swift

Init()

let win = Window()

win.showMessageBox(MessageBoxType.Information, title: "Hello", message: "This is a message")

//let win = Window(title: "Hello from Swift", width: 400, height: 300)
//win.resizeToWidth(1024, height: 768)
//win.hide()

createWindowAndWait()
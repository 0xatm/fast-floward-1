pub struct Canvas {
  pub let width: UInt8
  pub let height: UInt8
  pub let pixels: String

  init(width: UInt8, height: UInt8, pixels: String) {
    self.width = width
    self.height = height
    self.pixels = pixels
  }
}

pub resource Picture {
  pub let canvas: Canvas

  init(canvas: Canvas) {
    self.canvas = canvas
  }
}

pub fun serializeStringArray(_ lines: [String]): String {
  var buff = ""

  for line in lines {
    buff = buff.concat(line)
  }

  return buff
}

/* ====== W1Q1 STARTS ====== */
pub fun display(canvas: Canvas) {
  var idx: UInt8 = 0
  log("+-----+")
  while (idx < canvas.height) {
    var span = idx * canvas.width
    log("|".concat(canvas.pixels.slice(from: Int(span), upTo: Int(span + canvas.width))).concat("|"))
    idx = idx + 1
  }
  log("+-----+")
}
/* ====== W1Q1 ENDS ====== */

/* ====== W1Q2 STARTS ====== */
pub resource Printer {
  pub let array: [String]

  init() {
    self.array = []
  }

  pub fun print(canvas: Canvas): @Picture? {
    if(!self.array.contains(canvas.pixels)) {
      self.array.append(canvas.pixels)
      let picture <- create Picture(canvas: canvas)
      display(canvas: picture.canvas)
      return <- picture
    }
    return nil
  }
}
/* ====== W1Q2 ENDS ====== */

pub fun main() {
  let pixelsX = [
    "*   *",
    " * * ",
    "  *  ",
    " * * ",
    "*   *"
  ]

  let printer <- create Printer()

  let canvasX = Canvas(width: 5, height: 5, pixels: serializeStringArray(pixelsX))
  let picture <- printer.print(canvas: canvasX)
  destroy picture
  
  let anotherPic <- printer.print(canvas: canvasX)
  destroy anotherPic

  destroy printer
}

class RetroShooter
  tickMs: 33
  canvas: null
  ctx: null
  width: 640
  height: 480

  constructor: ->
    @canvas = document.createElement 'canvas'
    document.body.appendChild @canvas
    @canvas.width = @width
    @canvas.height = @height
    @ctx = @canvas.getContext '2d'

    setInterval @tick, @tickMs

  tick: =>
    @update()
    @draw()

  update: -> 0

  draw: ->
    @clear()
    @drawBackground()

  drawBackground: ->
    @ctx.lineWidth = 1
    for x in [0...@width]
      @drawVerticalLine 'rgb(' + (x % 256) + ', 0, 0)', x, 10, @height - 10

  drawVerticalLine: (color, x, y1, y2) ->
    @drawLine color, x + 0.5, y1, x + 0.5, y2

  drawLine: (color, x1, y1, x2, y2) ->
    @ctx.strokeStyle = color
    @ctx.beginPath()
    @ctx.moveTo x1, y1
    @ctx.lineTo x2, y2
    @ctx.stroke()
    @ctx.closePath()

  clear: ->
    @ctx.fillStyle = 'black'
    @ctx.fillRect 0, 0, @width, @height

class Player
  x: 0
  y: 0
  rotation: 30

class RetroShooter
  tickMs: 33
  canvas: null
  ctx: null
  width: 640
  height: 480
  player: new Player

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
    dir = @toRadians @player.rotation
    perpDir = @toRadians @player.rotation + 90
    sinPerpDir = Math.sin perpDir
    cosPerpDir = Math.cos perpDir
    centreDirX = 0.5 * Math.cos dir
    centerDirY = 0.5 * Math.sin dir
    for x in [0...@width]
      pct = x / @width - 0.5
      dirX = pct * cosPerpDir + centreDirX
      dirY = pct * sinPerpDir + centerDirY
      raycast = @raycast dirX, dirY
      color = raycast.color
      dx = raycast.hitX - @player.x - 0.5
      dy = raycast.hitY - @player.y - 0.5
      height = (@hypot 0.5, pct)/(@hypot dx, dy) * @height/2
      @drawVerticalLine color, x, height

  raycast: (dirX, dirY) ->
    color: 'blue', #TODO
    hitX: 2, #TODO
    hitY: 2 #TODO

  drawVerticalLine: (color, x, height) ->
    @drawLine color, x + 0.5, @height/2 - height, x + 0.5, @height/2 + height

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

  toRadians: (x) ->
    x * Math.PI / 180

  hypot: (x, y) ->
    Math.sqrt x * x, y * y

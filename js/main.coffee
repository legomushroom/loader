class Main
  constructor:(@o={})->
    @vars()
    @launch()

  vars:->
    @loader = document.getElementById('js-pie-loader')
    @loader1 = @loader.getElementById('js-pie-loader1')
    @loader2 = @loader.getElementById('js-pie-loader2')
    @loaderToggle = @loader.getElementById('js-pie-loader-toggle')
    # @toggleStyle = @loaderToggle.style

    @firstColor   = @getComutedStyle(@loader1).stroke
    @secondColor  = @getComutedStyle(@loader2).stroke
    @toggle = false
    @el = @loader2
    @delay = 3000
    @animate    = @bind @animate, @
    @animate()

  launch:->
    it = @
    @mainTween = new TWEEN.Tween( p: 0 )
      .to({ p: 1 }, 2*@o.duration or 2*@delay)
      .onUpdate(->if @p is 1 then it.tweens())
      .onStart(-> it.tweens())
      .repeat(99999999999).start()
    
  tweens:->
    it = @
    @tween2 = new TWEEN.Tween( offset: -24, p: 0 )
      .to({ offset: 0, p: 1 }, @o.duration or @delay)
      .onUpdate(->
        it.el.style['stroke-dashoffset'] = @offset*Math.PI
      )
    @tween = new TWEEN.Tween( offset: 0, p: 0 )
      .to({ offset: 24, p: 1 }, @o.duration or @delay)
      .onUpdate(->
        it.el.style['stroke-dashoffset'] = @offset*Math.PI
      ).chain(@tween2).start()

  stop:->     @tween.stop()
  destroy:->  TWEEN.remove(@tween); window.pieLoader = null
  play:->     @tween.play()

  getComutedStyle:(el)->
    if window.getComputedStyle
      getComputedStyle(el)
    else el.currentStyle

  animate:->
    requestAnimationFrame(@animate)
    TWEEN.update()

  bind:(func, context) ->
    wrapper = ->
      args = Array::slice.call(arguments)
      unshiftArgs = bindArgs.concat(args)
      func.apply context, unshiftArgs
    bindArgs = Array::slice.call(arguments, 2)
    wrapper

window.pieLoader = Main
new window.pieLoader

class Main
  constructor:(@o={})->
    @vars()
    @launch()

  vars:->
    @loader = document.getElementById('js-pie-loader')
    @loader1 = document.getElementById('js-pie-loader1')
    @loader2 = document.getElementById('js-pie-loader2')
    @loaderToggle = document.getElementById('js-pie-loader-toggle')
    @toggleStyle = @loaderToggle.style

    @firstColor   = @getComutedStyle(@loader1).stroke
    @secondColor  = @getComutedStyle(@loader2).stroke
    @toggle = false
    @el = @loader2
    @animate    = @bind @animate, @
    @animate()

  launch:->
    it = @
    @tween = new TWEEN.Tween( offset: 0, p: 0 )
      .to({ offset: 24, p: 1 }, @o.duration or 2000)
      .onUpdate(->
        it.el.style['stroke-dashoffset'] = @offset*Math.PI
        if @p is 1
          it.toggle = !it.toggle
          it.el = if (it.toggle) then it.loader1 else it.loader2
          color = if (!it.toggle) then it.firstColor else it.secondColor
          setTimeout ->
            it.toggleStyle.stroke = color
          , 1
      ).repeat(9999999999).start()

  stop:->     console.log 'implement me'
  destroy:->  console.log 'implement me'
  play:->     console.log 'implement me'

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


new Main
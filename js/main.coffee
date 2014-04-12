class Main
  constructor:(@o={})->
    @vars()
    @launch()

  vars:->
    @loader = document.querySelector('#js-pie-loader')
    @loader1 = @loader.querySelector('#js-pie-loader1')
    @loader2 = @loader.querySelector('#js-pie-loader2')
    @loaderToggle = @loader.querySelector('#js-pie-loader-toggle')
    @loaderText = @loader.querySelector('#js-pie-loader-text')

    @firstColor   = @getComutedStyle(@loader1).stroke
    @secondColor  = @getComutedStyle(@loader2).stroke
    @color1 = []
    @color1 = for part, i in @firstColor.split ','
      if i is 0
        part = part.replace 'rgb(', ''
      parseInt part, 10

    @color2 = for part, i in @secondColor.split ','
      if i is 0
        part = part.replace 'rgb(', ''
      parseInt part, 10

    @toggle = false
    @el = @loader2
    @delay = 4000
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
    @tween2 = new TWEEN.Tween(
      offset: -24
      p: 0
      r: @color1[0]
      g: @color1[1]
      b: @color1[2]
      )
      .to({
        offset: 0
        r: @color2[0]
        g: @color2[1]
        b: @color2[2]
        p: 1 
      }, @o.duration or @delay)
      .onUpdate(->
        it.el.style['stroke-dashoffset'] = @offset*Math.PI
        it.loaderText.style['color'] = "rgb(#{parseInt(@r,10)},#{parseInt(@g,10)},#{parseInt(@b,10)})"
      )
    @tween = new TWEEN.Tween( 
        offset: 0
        p: 0
        r: @color2[0]
        g: @color2[1]
        b: @color2[2]
      )
      .to({ 
        offset: 24
        p: 1
        r: @color1[0]
        g: @color1[1]
        b: @color1[2]
      }, @o.duration or @delay)
      .onUpdate(->
        it.el.style['stroke-dashoffset'] = @offset*Math.PI
        it.loaderText.style['color'] = "rgb(#{parseInt(@r,10)},#{parseInt(@g,10)},#{parseInt(@b,10)})"
      ).chain(@tween2).start()

  destroy:->  TWEEN.remove(@tween,@tween2,@mainTween); window.pieLoader = null

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
window.r = new window.pieLoader


# class Main
#   constructor:(@o={})->
#     @vars()
#     @launch()

#   vars:->
#     @loader = document.querySelector('#js-pie-loader')
#     @loader1 = @loader.querySelector('#js-pie-loader1')
#     @loader2 = @loader.querySelector('#js-pie-loader2')
#     @loaderText = @loader.querySelector('#js-pie-loader-text')
#     @loaderToggle = @loader.querySelector('#js-pie-loader-toggle')

#     @firstColor   = @getComutedStyle(@loader1).stroke
#     @secondColor  = @getComutedStyle(@loader2).stroke
#     @toggle = false
#     @el = @loader2
#     @delay = 4000
#     @animate    = @bind @animate, @
#     @animate()

#   launch:->
#     it = @
#     @mainTween = new TWEEN.Tween( p: 0 )
#       .to({ p: 1 }, 2*@o.duration or 2*@delay)
#       .onUpdate(->if @p is 1 then it.tweens())
#       .onStart(=> @frame())
#       .repeat(99999999999).start()

#     @mainDotsTween = new TWEEN.Tween( p: 0 )
#       .to({ p: 1 }, @o.duration/2 or @delay/2)
#       .onUpdate(->if @p is 1 then it.dots())
#       .onStart(=> @frame())
#       .repeat(99999999999).start()

#   frame:->
#     @tweens()
#     @dots()
    
#   tweens:->
#     it = @
#     @tween2 = new TWEEN.Tween( offset: -24, p: 0 )
#       .to({ offset: 0, p: 1 }, @o.duration or @delay)
#       .onUpdate(->
#         it.el.style['stroke-dashoffset'] = @offset*Math.PI
#       )
#     @tween = new TWEEN.Tween( offset: 0, p: 0 )
#       .to({ offset: 24, p: 1 }, @o.duration or @delay)
#       .onUpdate(->
#         it.el.style['stroke-dashoffset'] = @offset*Math.PI
#       ).chain(@tween2).start()

#   dots:->
#     it = @
#     @dot1 = new TWEEN.Tween( p: 0 )
#       .to({ p: 1 }, @o.duration/8 or @delay/8)
#       .onUpdate(->
#         it.loaderText.innerHTML = 'loading...'
#       )
#     @dot2 = new TWEEN.Tween( p: 0 )
#       .to({ p: 1 }, @o.duration/8 or @delay/8)
#       .onUpdate(->
#         it.loaderText.innerHTML = 'loading..&nbsp;'
#       ).chain(@dot1)
#     @dot3 = new TWEEN.Tween( p: 0 )
#       .to({ p: 1 }, @o.duration/8 or @delay/8)
#       .onUpdate(->
#         it.loaderText.innerHTML = 'loading.&nbsp;&nbsp;'
#       ).chain(@dot2)
#     @dot4 = new TWEEN.Tween( p: 0 )
#       .to({ p: 1 }, @o.duration/8 or @delay/8)
#       .onUpdate(->
#         it.loaderText.innerHTML = 'loading&nbsp;&nbsp;&nbsp;'
#       ).chain(@dot3).start()



#   stop:->     @tween.stop()
#   destroy:->  TWEEN.remove(@tween); window.pieLoader = null
#   play:->     @tween.play()

#   getComutedStyle:(el)->
#     if window.getComputedStyle
#       getComputedStyle(el)
#     else el.currentStyle

#   animate:->
#     requestAnimationFrame(@animate)
#     TWEEN.update()

#   bind:(func, context) ->
#     wrapper = ->
#       args = Array::slice.call(arguments)
#       unshiftArgs = bindArgs.concat(args)
#       func.apply context, unshiftArgs
#     bindArgs = Array::slice.call(arguments, 2)
#     wrapper

# window.pieLoader = Main
# new window.pieLoader

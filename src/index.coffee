require("./Framer")

# Made with Framer
# by Pete Lada
# www.framerjs.com

# Background
bg = new BackgroundLayer backgroundColor: "#439FD8", name:"BackgroundLayer"

console.log(bg)

# Defaults and variables
animSpeed = .25
defaultAnimCurve = "spring(250,25,5)"
smallBounce = "spring(250,25,2)"
margin = 20

noAnim = 
  curve: "ease"
  time: 0
  delay: 0
logoDefaultAnim = 
  curve: "ease"
  time: .2
  delay: 0
logoReturningAnim = 
  curve: defaultAnimCurve
  time: .3
  delay: .1

Framer.Defaults.Animation =
   curve: defaultAnimCurve
   time: animSpeed

# Create image layers
photoArea = new Layer x:0, y:0, width:640, height:640, image:"images/photo-area.png", scale: .86, opacity: 0, name: "photoArea"
  
closePhoto = new Layer x: 560, y: 40, width: 50, height: 50, backgroundColor: "transparent", name: "closePhoto"

container = new Layer x: 0, y:0, width: 640, height: 1136, backgroundColor: "transparent", name: "container"

container.clip = false
container.scroll = true
container.states.animationOptions = curve: smallBounce
  
containerMask = new Layer x: 0, y: -50, width: 640, height: 1963 + 50, backgroundColor: "rgba(0,0,0,.8)", opacity:0 , name: "containerMask"

header = new Layer x: 0, y: 0, width: 640, height: 413, backgroundColor: "#439FD8", name: "header"

logo = new Layer  x:0, y:114, width:328, height:70, image:"images/guidebook_logo_dark.png", name: "logo"
  
store = new Layer  x:0, y:413, width:640, height:1963, image:"images/store.png", name: "store"
  
codePlaceholder = new Layer x:20, y:22, width:171, height:34, image:"images/code-placeholder.png", opacity: 0, name: "codePlaceholder"

searchBar = new Layer x:30, y:304, width:580, height:79, backgroundColor: "white", borderRadius: "8px", name: "searchBar"
searchBar.shadowX = 0
  
searchPlaceholder = new Layer x:20, y:22, width:171, height:37, image:"images/search-placeholder.png", name: "searchPlaceholder"
  
reset = new Layer x: 0, y: 413, width: 640, height: 2376, backgroundColor: "rgba(255,255,255,.6)", opacity: 0, name: "reset"

redeemText = new Layer  x:0, y:114, width:362, height:65, image:"images/redeem-text.png", opacity: 0, name: "redeemText"

cancelSearch = new Layer x:525, y:20, width:40, height:40, image:"images/cancel-search.png", opacity: 0, index: 0, name: "cancelSearch"

useCode = new Layer x:0, y:searchBar.y-30-43, width:180, height:43, image:"images/use-code.png", name: "useCode"
useCode.centerX()

qrButton = new Layer x: searchBar.width - 200, y: 0, width: 200, height: searchBar.height, backgroundColor: "transparent", name: "qrButton"
qr = new Layer x:150, y:0, width:34, height:34, image:"images/qr.png", name: "qr"
ptr = new Layer x:0, y: header.height - 100, height: 100, width: 640, backgroundColor:"transparent", name: "ptr"
ptrBorder = new Layer x: 0, y: ptr.height-2, height: 2, width: 640, backgroundColor: "#D7E1E9", name: "ptrBorder"
arrow = new Layer x:0, y:0, width:33, height:44, image:"images/pull-arrow.png", name: "arrow"
refresh = new Layer x:0, y:0, width:44, height:44, image:"images/refresh.png", opacity: 0, name: "refresh"

# Add sublayers
ptr.addSubLayer arrow
ptr.addSubLayer ptrBorder
ptr.addSubLayer refresh
arrow.center()
refresh.center()
ptr.index = 0

qrButton.addSubLayer qr

container.addSubLayer store
container.addSubLayer header
container.addSubLayer containerMask
container.addSubLayer reset

header.addSubLayer useCode
header.addSubLayer redeemText
header.addSubLayer logo
header.addSubLayer searchBar
    
searchBar.addSubLayer searchPlaceholder
searchBar.addSubLayer codePlaceholder
codePlaceholder.centerY()
searchBar.addSubLayer qrButton
qr.centerY()
searchBar.addSubLayer cancelSearch

# Center redeem and logo within parent
redeemText.centerX()
logo.centerX()

# States for various items
qrButton.states.add
  hidden:
    opacity: 0

container.states.add
  scanning:
    y: photoArea.height
    
photoArea.states.add
  scanning:
    scale: 1
    opacity: 1
    
containerMask.states.add
  scanning:
    opacity: 1
  
header.states.add
  searching: 
    y: -(header.height - margin - searchBar.height - margin)
  redeeming:
    height: header.height  - useCode.height - margin
  stickySearch:
    y: 0
    height: margin + searchBar.height + margin
  stickyReturn:
    y: 0
    height: 413
    
searchBar.states.add
  searching:
    y: header.height - margin - searchBar.height
  redeeming:
    y: useCode.y
  sticky:
    y: margin
  stickyReturn:
    y:304

reset.states.add
  searching:
    opacity: 1
    y: margin + searchBar.height + margin
  usingCode:
    opacity: 1
    y: header.height - useCode.height - margin
  scanning:
    opacity: .001
    y: 0

codePlaceholder.states.add
  redeeming:
    opacity: 1

redeemText.states.add
  visible: 
    opacity: 1
    
useCode.states.add  
  hidden:
    opacity: 0
  pressed:
    scale: .9
    
logo.states.add
  searching:
    y: logo.y - 50
    opacity: 0
    
  returning:
    y: logo.y
    opacity: 1
  
  hidden:
    opacity: 0
  
store.states.add
  searching:
    y: 20 + searchBar.height + 20
    opacity: 1
    
  redeeming:
    y: header.height - useCode.height - margin
    
  scanning:
    y: header.height + photoArea.height
    blur: 5
  
  refreshing:
    y: header.height + 100
    
searchPlaceholder.states.add
  hidden:
    opacity:0
    x: searchPlaceholder.x - 100
    
cancelSearch.states.add
  visible:
    opacity: 1
    index: 1
    
ptr.states.add
  refreshing:
    y: header.height

redeemText.states.animationOptions =
  curve: "ease"
  time: animSpeed
  
searchPlaceholder.states.animationOptions = 
  curve: smallBounce
  time: animSpeed
  
cancelSearch.states.animationOptions = 
  curve: "ease"
  time: animSpeed

# State functions
resetView = ->
  searchPlaceholder.states.switch "default"
  qrButton.states.switch "default"
  header.states.switch "default"
  logo.states.switch "returning"
  store.states.switch "default"
  reset.states.switch "default"
  cancelSearch.states.switch "default"
  redeemText.states.switch "default"

  #*****
  searchBar.states.switch "default"

  useCode.states.switch "default"
  container.states.switch "default"

  #*****
  containerMask.states.switch "default"

  photoArea.states.switch "default"

  #*****
  codePlaceholder.states.switch "default"
  
  Utils.delay 0.5, ->
    bg.backgroundColor = "#439FD8"
  qrButton.index = 100

initSearch = ->
  if !sticky
    header.states.switch "searching"
    logo.states.switch "searching"
    qrButton.states.switch "hidden"
    store.states.switch "searching"
    reset.states.switch "searching"
    cancelSearch.states.switch "visible"
    searchBar.states.switch "searching"
    useCode.states.switch "hidden"
    qrButton.index = 0
  else
    reset.states.switch "searching"
  
initRedeem = ->
  searchPlaceholder.states.switch "hidden"
  reset.states.switch "usingCode"
  searchBar.states.switch "redeeming"
  cancelSearch.states.switch "visible"
  redeemText.states.switch "visible"
  logo.states.switch "hidden"
  useCode.states.switch "hidden"
  header.states.switch "redeeming"
  store.states.switch "redeeming"
  codePlaceholder.states.switch "redeeming"
  qrButton.states.switch "hidden"
  qrButton.index = 0

initScan = ->
  container.states.switch "scanning"
  reset.states.switch "scanning"
  containerMask.states.switch "scanning"
  bg.backgroundColor = "black"
  photoArea.states.switch "scanning"
  
initStickySearch = ->
  header.states.switch "stickySearch"
  logo.states.switch "hidden"
  container.removeSubLayer header
  searchBar.states.switch "sticky"
  
cancelStickySearch = ->
  container.addSubLayer header
  header.index = 1
  header.states.switch "stickyReturn"
  searchBar.states.switch "stickyReturn"
  searchBar.states.switch "default"
  
  
# Events
searchPlaceholder.on Events.Click, ->
  console.log "searchPlaceholder on Click"
  initSearch()
  
qrButton.on Events.Click, ->
  initScan()
  
qr.on Events.Click, ->
  initScan()

useCode.on Events.TouchStart, ->
  this.states.switch "pressed"

useCode.on Events.MouseOut, ->
  this.states.switch "default"

useCode.on Events.Click, ->
  initRedeem()
  
reset.on Events.Click, ->
  resetView()
  
cancelSearch.on Events.Click, ->
  console.log "cancelSearch on Click"
  # searchPlaceholder.states.switch "default"
  resetView()
  
closePhoto.on Events.Click, ->
  resetView()

# State switch functions
# These change the animation for an item based on its new state
logo.states.on Events.StateWillSwitch, (oldState, newState) ->
  if newState == 'returning'
    logo.states.animationOptions = logoReturningAnim
  else
    logo.states.animationOptions = logoDefaultAnim
    
reset.on Events.AnimationStart, (event, layer) ->
  layer.visible = true
    
reset.on Events.AnimationEnd, (event, layer) ->
  if layer.opacity == 0
    layer.visible = false
  else 
    layer.visible = true
    
header.on Events.StateWillSwitch, (oldState, newState) ->
  if newState ==  "stickyReturn"
    header.states.animationOptions = noAnim
  else if newState == "stickySearch"
    header.states.animationOptions = noAnim
  else
    header.states.animationOptions = Framer.Defaults.Animation
    
searchBar.on Events.StateWillSwitch, (oldState, newState) ->
  if newState is "sticky" or sticky   
    searchBar.states.animationOptions = noAnim
  else
    searchBar.states.animationOptions = Framer.Defaults.Animation

# Pull to refresh
spin = ->
  refresh.animate
    properties:
      rotation: 1080
    time: 1.5
    curve: "linear"
  Utils.delay 1.5, ->
    refresh.rotation = 0
    spin()
spin()

startY = 0
storeStartY = store.y
store.draggable.enabled = true
store.draggable.speedX = 0

store.on Events.DragStart, (event) ->
  bg.backgroundColor = "#F6FBFE"
  startY = event.pageY

store.on Events.DragMove, (event) ->
  deltaY = startY - event.pageY
  store.y = storeStartY - deltaY
  ptr.y = store.y - ptr.height
  
  if deltaY > 0 
    header.y = -deltaY
  
  if deltaY < -100
    arrow.animate
      properties:
        rotation: 180
      time: .12
      curve: "ease"
  else
    arrow.animate
      properties:
        rotation: 0
      time: .12
      curve: "ease"
      
store.on Events.DragEnd, (event) ->
  deltaY = startY - event.pageY
  if deltaY < -100
    startRefresh()
  else
    store.states.switch "default"
    ptr.states.switch "default"
    header.states.switch "default"
    
startRefresh = ->
  store.states.switch "refreshing"    
  ptr.states.switch "refreshing"
  refresh.animate
    properties:
      opacity: 1
    time: .2
    curve: "ease"
    
  arrow.animate
    properties:
      opacity: 0
    time: .2
    curve: "ease"
    
  Utils.delay 2, ->
    endRefresh()
      
endRefresh = ->
  store.states.switch "default"
  ptr.states.switch "default"
  refresh.opacity = 0
    
  arrow.animate
    properties:
      opacity: 1
    time: .2
    curve: "ease"
    
  Utils.delay .2, ->
    bg.backgroundColor = "#439FD8"
    arrow.rotation = 0
    
# Scroll events
sticky = false
opacity = 1
limit = header.height - 20 - searchBar.height - 20
container.on Events.Scroll, ->
  x = Utils.modulate(container.scrollY, [0, limit-100], [1, 0], true)
  y = Utils.modulate(container.scrollY, [0, limit], [1, 0], true)
  logo.opacity = x
  useCode.opacity = y
  if container.scrollY > limit
    if !sticky
      initStickySearch()
      sticky = true
  else
    cancelStickySearch()
    sticky = false
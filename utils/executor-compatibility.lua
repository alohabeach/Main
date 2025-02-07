if not getgenv then return end

getgenv().getgc = getgc or get_gc_objects
getgenv().getreg = getreg or debug.getregistry
getgenv().getinfo = getinfo or debug.getinfo
getgenv().getfenv = getfenv or debug.getfenv
getgenv().getsenv = getsenv or debug.getsenv
getgenv().getmenv = getmenv or debug.getmenv
getgenv().getrenv = getrenv or debug.getrenv
getgenv().getprotos = getprotos or debug.getprotos
getgenv().getproto = getproto or debug.getproto
getgenv().setproto = setproto or debug.setproto
getgenv().getupvalues = getupvalues or debug.getupvalues
getgenv().getupvalue = getupvalue or debug.getupvalue
getgenv().setupvalue = setupvalue or debug.setupvalue
getgenv().islclosure = islclosure or debug.islclosure
getgenv().getconstants = getconstants or debug.getconstants
getgenv().getconstant = getconstant or debug.getconstant
getgenv().setconstant = setconstant or debug.setconstant
getgenv().hookfunction = hookfunction or replaceclosure
getgenv().firesignal = firesignal or debug.firesignal
getgenv().request = request or http_request or (http and http.request)
getgenv().identifyexecutor = identifyexecutor or getexecutorname
getgenv().getscriptclosure = getscriptclosure or getscriptfunction
getgenv().queue_on_teleport = queue_on_teleport or queueonteleport
getgenv().setclipboard = setclipboard or toclipboard
getgenv().getscriptbytecode = getscriptbytecode or dumpstring
getgenv().getthreadidentity = getthreadidentity or getidentity or getthreadcontext
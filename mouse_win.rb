require 'Win32API'
 
getCursorPos = Win32API.new("user32", "GetCursorPos", ['P'], 'V')
lpPoint = " " * 8 # store two LONGs
getCursorPos.Call(lpPoint)
x, y = lpPoint.unpack("LL") # get the actual values
print "x: ", x, "\n"
print "y: ", y, "\n"
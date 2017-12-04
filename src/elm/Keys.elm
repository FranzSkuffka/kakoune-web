module Keys exposing (mapKey)
import Dict exposing ( fromList, get )

mapKey key = Maybe.withDefault
  ""
  <| get key (Dict.fromList keys)

keys = [
   (8 ,"Backspace")
  ,(9 ,"Tab")
  ,(13, "<ret>")
  ,(16, "Shift")
  ,(17, "Ctrl")
  ,(27, "<esc>")
  ,(32, "Space")
  ,(33, "Page up")
  ,(34, "Page down")
  ,(35, "End")
  ,(36, "Home")
  ,(37, "Right arrow")
  ,(38, "Up arrow")
  ,(39, "Left arrow")
  ,(40, "Down arrow")
  ,(45, "Insert")
  ,(46, "Delete")
  ,(49, "1")
  ,(50, "2")
  ,(51, "3")
  ,(52, "4")
  ,(53, "5")
  ,(54, "6")
  ,(55, "7")
  ,(56, "8")
  ,(57, "9")
  ,(58, "0")
  ,(59, ":")
  ,(65, "a")
  ,(66, "b")
  ,(67, "b")
  ,(68, "d")
  ,(69, "e")
  ,(70, "f")
  ,(71, "g")
  ,(72, "h")
  ,(73, "i")
  ,(74, "j")
  ,(75, "k")
  ,(76, "l")
  ,(77, "m")
  ,(78, "n")
  ,(79, "o")
  ,(80, "p")
  ,(81, "q")
  ,(82, "r")
  ,(83, "s")
  ,(84, "t")
  ,(85, "u")
  ,(86, "v")
  ,(87, "w")
  ,(88, "x")
  ,(89, "y")
  ,(90, "z")
  ,(91, "Command left")
  ,(91, "Meta")
  ,(91, "Super")
  ,(91, "Windows")
  ,(93, "Command right")
  ,(113, "F2")
  ,(115, "F4")
  ,(119, "F8")
  ,(120, "F9")
  ,(121, "F10")
  ]

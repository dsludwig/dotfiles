Config { font = "xft:Inconsolata-12:antialias=true"
       , borderColor = "black"
       , border = TopB
       , bgColor = "black"
       , fgColor = "grey"
       , position = Top
       , lowerOnStart = True
       , persistent = False
       , hideOnStart = False
       , commands = [ Run Weather "CYVR" ["-t","<station>: <tempC>C","-L","18","-H","25","--normal","green","--high","red","--low","lightblue"] 36000
                    , Run Wireless "wlp2s0" ["-L","30","-H","70","--low","red", "--normal", "lightblue" ,"--high","green"] 10
                    , Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 10
                    , Run Memory ["-t","Mem: <usedratio>%"] 10
                    , Run Battery [] 10
                    , Run Date "%a %b %_d %Y %H:%M:%S" "date" 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% } %cpu%  %memory%  %battery%  Wifi: %wlp2s0wi% { <fc=#ee9a00>%date%</fc> | %CYVR%"
       }

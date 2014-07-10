import XMonad
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.WorkspaceCompare
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Tabbed
import XMonad.Layout.Accordion
import XMonad.Layout.NoBorders -- (noBorders)
import Data.List

-- Solarized colors
base03      = "#002b36"
base02      = "#073642"
base01      = "#586e75"
base00      = "#657b83"
base0       = "#839496"
base1       = "#93a1a1"
base2       = "#eee8d5"
base3       = "#fdf6e3"
yellow      = "#b58900"
orange      = "#cb4b16"
red         = "#dc322f"
magenta     = "#d33682"
violet      = "#6c71c4"
blue        = "#268bd2"
cyan        = "#2aa198"

-- Default dark bg/fg
background = base03
foreground = base0
bitmapsDir = ".xmonad/dzen2"

myLayoutHook = smartBorders $ layoutHook defaultConfig
myManageHook = composeAll (
  [ className =? "mpv" --> doFullFloat
  , className =? "KeePass2" --> doShift "8"
  , className =? "Skype" --> doShift "9"
  , isFullscreen --> doFullFloat
  ])

quote color = "'" ++ color ++ "'"
fontFlag = "-fn Inconsolata-12"
dzenCmd = "/usr/bin/dzen2 " ++ flags
  where
    disableRightClick = "-e " ++ quote "button2=;"
    screen = "-xs 1"
    bg = "-bg " ++ quote background
    fg = "-fg " ++ quote foreground
    flags = intercalate " " [disableRightClick, screen, bg, fg, fontFlag, "-dock"]

conkyCmd = "/usr/bin/conky | /usr/bin/dzen2 " ++ flags
  where
    disableRightClick = "-e " ++ quote "button2=;"
    screen = "-xs 2"
    bg = "-bg " ++ quote background
    fg = "-fg " ++ quote foreground
    flags = intercalate " " [disableRightClick, screen, bg, fg, fontFlag]

main = do
  -- xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobar.hs"
  dzenproc <- spawnPipe dzenCmd
  xmonad $ ewmh $ defaultConfig
              { modMask = mod4Mask
              , manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
              , layoutHook = avoidStruts myLayoutHook
              , logHook = dzenLogHook dzenproc
              , normalBorderColor = base0
              , focusedBorderColor = red
              , startupHook = spawnOnce conkyCmd
              } `additionalKeysP` theseKeys

xmobarLogHook h = dynamicLogWithPP xmobarPP
  { ppOutput = hPutStrLn h
  , ppTitle = xmobarColor "blue" "" . shorten 80
  , ppSort = getSortByXineramaPhysicalRule
  , ppVisible = wrap "[" "]"
  }

dzenLogHook h = dynamicLogWithPP dzenPP
  { ppOutput = hPutStrLn h
  , ppTitle = dzenColor base0 base03 . shorten 100 . pad
  , ppSort = getSortByXineramaPhysicalRule
  , ppCurrent = dzenColor base0 base3 . pad
  , ppVisible = dzenColor base1 base2 . pad
  , ppHidden = dzenColor base00 base02 . pad
  --, ppLayout = dzenColor base00 base02 . pad
  , ppLayout = pad . (\x -> case x of
      "Tall" -> "^i(" ++ bitmapsDir ++ "/tall.xbm)"
      "Mirror Tall" -> "^i(" ++ bitmapsDir ++ "/mtall.xbm)"
      "Full" -> "^i(" ++ bitmapsDir ++ "/full.xbm)"
      _      -> x
    )
  }

dmenuCmd = "/usr/bin/dmenu_run " ++ flags
  where
    bg = "-nb " ++ quote background
    fg = "-nf " ++ quote foreground
    sbg = "-sb " ++ quote base3
    sfg = "-sf " ++ quote base0
    flags = intercalate " " [fontFlag, fg, bg, sfg, sbg]

theseKeys =
  [
    ("M4-<Escape>", spawn "xscreensaver-command -lock"),
    ("M4-p", spawn dmenuCmd),
    ("<XF86AudioRaiseVolume>", spawn "amixer -q set Master 1+"),
    ("<XF86AudioLowerVolume>", spawn "amixer -q set Master 1-"),
    ("<XF86AudioMute>", spawn "amixer -q set Master toggle")
  ]

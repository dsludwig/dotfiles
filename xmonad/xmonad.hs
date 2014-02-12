import XMonad
import XMonad.Util.Run
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Tabbed
import XMonad.Layout.Accordion
import XMonad.Layout.NoBorders -- (noBorders)

myLayoutHook = smartBorders $ layoutHook defaultConfig
myManageHook = composeAll (
  [ className =? "Unity-2d-panel" --> doIgnore
  , className =? "Unity-2d-launcher" --> doFloat
  , className =? "xmbc.bin" --> doFullFloat
  , isFullscreen --> doFullFloat
  ])

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmonad/xmobar.hs"
  xmonad $ defaultConfig
              { modMask = mod4Mask
              , manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
              , layoutHook = avoidStruts myLayoutHook
              , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "blue" "" . shorten 80
                        }
              } `additionalKeysP` theseKeys

theseKeys =
  [
    ("M4-<Escape>", spawn "xscreensaver-command -lock"),
    ("M4-p", spawn "dmenu_run -fn Inconsolata-12"),
    ("<XF86AudioRaiseVolume>", spawn "amixer set Master 1+"),
    ("<XF86AudioLowerVolume>", spawn "amixer set Master 1-")
  ]

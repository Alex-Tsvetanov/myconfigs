--import statements
import XMonad
import XMonad.Layout.SimpleFloat
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Util.NamedWindows
import XMonad.Util.Run
import XMonad.Hooks.SetWMName

import Data.Bits ((.|.))

import qualified XMonad.StackSet as W

-- TaffyBar
import XMonad.Hooks.EwmhDesktops --(ewmh)
import System.Taffybar.Hooks.PagerHints (pagerHints) 

--Notifications
data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        Just idx <- fmap (W.findTag w) $ gets windowset
	safeSpawn "notify-send" [show name, "workspace " ++ idx]

-- Define default layouts used on most workspaces
defaultLayouts = tiled ||| Mirror tiled ||| simpleFloat ||| Full
    where
        -- default tiling algorithm partitions the screen into two panes
        tiled   = Tall nmaster delta ratio
        -- The default number of windows in the master pane
        nmaster = 1
        -- Default proportion of screen occupied by master pane
        ratio   = 1/2
        -- Percent of screen to increment by when resizing panes
        delta   = 3/100
 
-- Define the names of all workspaces
myWorkspaces = ["1","2","3","4","5","6","7","8","9", "10"]

myKeys =
    [
	 ((0,xF86XK_MonBrightnessDown), spawn "xbacklight -20")
	,((0,xF86XK_MonBrightnessUp), spawn "xbacklight +20")
	,((0,xF86XK_AudioLowerVolume), spawn "pamixer --decrease 1")
	,((0,xF86XK_AudioRaiseVolume), spawn "pamixer --increase 1")
	,((0,xF86XK_AudioMute), spawn "pamixer --toggle-mute")
	,((mod4Mask .|. shiftMask, xK_z), spawn "/home/alex/.i3/lock")
	,((mod4Mask .|. shiftMask, xK_p     ), spawn "dmenu_run")
	,((mod4Mask .|. shiftMask, xK_t     ), spawn "transset-df 0.5")
    ]
    ++
    [((m .|. mod4Mask, k), windows $ f i)
	| (i, k) <- zip myWorkspaces [xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7, xK_8, xK_9, xK_0]
	, (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

myLayouts =  defaultLayouts

-- Define terminal
myTerminal = "urxvt"

--Startup applications
startup= do
	 spawn "taffybar &"
	 spawn "nm-applet"
	 spawn "blueman-applet"
	 spawn "/home/alex/.fehbg"
	 spawn "wmname LG3D"
	 spawn "xcompmgr"
	 spawn "setxkbmap -option grp:switch,grp:alt_shift_toggle,grp_led:scroll us,bg"

--XMonad Config
xmonadConfig = ewmh $ pagerHints $ withUrgencyHook LibNotifyUrgencyHook $ defaultConfig
	{
		manageHook = composeAll [
		    manageDocks,
		    isFullscreen --> doFullFloat,
		    manageHook defaultConfig
		  ],
		modMask=mod4Mask,
		workspaces = myWorkspaces,
		terminal = myTerminal,
		layoutHook = myLayouts,
		startupHook = startup
		, logHook = do
			-- updatePointer (0.5, 0.5) (0.2, 0.2)
	      		ewmhDesktopsLogHook
	}`additionalKeys` myKeys
--	[
--		 ((0,xF86XK_MonBrightnessDown), spawn "xbacklight -20")
--		,((0,xF86XK_MonBrightnessUp), spawn "xbacklight +20")
--		,((0,xF86XK_AudioLowerVolume), spawn "pamixer --decrease 1")
--		,((0,xF86XK_AudioRaiseVolume), spawn "pamixer --increase 1")
--		,((0,xF86XK_AudioMute), spawn "pamixer --toggle-mute")
--		,((mod4Mask .|. shiftMask, xK_z), spawn "/home/alex/.i3/lock")
--		,((mod4Mask .|. shiftMask, xK_p     ), spawn "dmenu_run")
--		,((mod4Mask, xK_t     ), spawn "transset-df 0.5")
--	]
-- Run XMonad
main :: IO ()
main = xmonad =<< xmobar xmonadConfig


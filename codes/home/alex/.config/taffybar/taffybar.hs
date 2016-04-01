import System.Taffybar

import System.Taffybar.Systray
import System.Taffybar.SimpleClock
import System.Taffybar.FreedesktopNotifications
import System.Taffybar.Weather
import System.Taffybar.MPRIS

import System.Taffybar.Widgets.PollingBar
import System.Taffybar.Widgets.PollingGraph

import System.Information.Memory
import System.Information.CPU

--import Graphics.UI.Gtk.General.RcStyle (rcParseString)
import System.Taffybar.Battery

import System.Taffybar.NetMonitor

import System.Taffybar.Pager
import System.Taffybar.WorkspaceSwitcher
import System.Taffybar.WindowSwitcher
import System.Taffybar.LayoutSwitcher

memCallback = do
  mi <- parseMeminfo
  return [memoryUsedRatio mi]

cpuCallback = do
  (userLoad, systemLoad, totalLoad) <- cpuLoad
  return [totalLoad, systemLoad]

main = do
  let memCfg = defaultGraphConfig { graphDataColors = [(1, 0, 0, 1)]
                                  , graphLabel = Just "mem"
                                  }
      cpuCfg = defaultGraphConfig { graphDataColors = [ (0, 1, 0, 1)
                                                      , (1, 0, 1, 0.5)
                                                      ]
                                  , graphLabel = Just "cpu"
                                  }
      clockCfg = "<span fgcolor='orange'>%a %b %_d %H:%M:%S</span>"
      weaCfg = (defaultWeatherConfig "LBSF") {
             weatherTemplate = "$tempC$°C" }
  
  pager <- pagerNew defaultPagerConfig 
                  { activeWindow     = colorize "#ffca00" "" . escape . shorten 30
                  , activeLayout     = escape
                  , activeWorkspace  = colorize "#ffca00" "" . escape
                  , hiddenWorkspace  = colorize "#aaaaaa" "" . escape
                  , emptyWorkspace   = colorize "#666666" "" . escape
                  , visibleWorkspace = colorize "#a88500" "" . escape
                  , urgentWorkspace  = colorize "red" "yellow" . escape
                  , widgetSep        = " : "
                  }

  let clock = textClockNew Nothing clockCfg 1
--      note  = notifyAreaNew defaultNotificationConfig
      wea   = weatherNew weaCfg 10
--      mpris = mprisNew
      mem   = pollingGraphNew memCfg 2 memCallback
      cpu   = pollingGraphNew cpuCfg 2 cpuCallback
      batt  = batteryBarNew defaultBatteryConfig 10
      wifi  = netMonitorNew 2 "wlp1s0"
      cabel = netMonitorNew 2 "enp2s0"
      tray  = systrayNew
      font  = "Monospace 9"
      wss = wspaceSwitcherNew pager
      los = layoutSwitcherNew pager
      wnd = windowSwitcherNew pager

--  rcParseString $ ""
--                ++ "style \"default\" {"
--                ++ " font_name = \"" ++ font ++ "\""
--                ++ " bg[NORMAL] = {0.0, 0.0, 0.0}"
--                ++ "}"

  defaultTaffybar defaultTaffybarConfig
                  { barHeight = 26
                  , startWidgets = [ ]--wss,los,wnd]-- note ]
                  , endWidgets = [ tray, wea, clock
                                 , batt
                                 , mem, cpu, wifi, cabel--, mpris
                                 ]
                  }

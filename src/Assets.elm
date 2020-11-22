module Assets exposing (menu, star)

import Svg exposing (..)
import Svg.Attributes exposing (..)


menu =
    svg [ viewBox "0 0 32 32", fill "#e2eff2" ]
        [ Svg.path [ d "M 4 7 L 4 9 L 28 9 L 28 7 Z M 4 15 L 4 17 L 28 17 L 28 15 Z M 4 23 L 4 25 L 28 25 L 28 23 Z" ]
            []
        ]


star color =
    svg [ viewBox "0 0 512 512", fill color ]
        [ Svg.path [ d "M394,480a16,16,0,0,1-9.39-3L256,383.76,127.39,477a16,16,0,0,1-24.55-18.08L153,310.35,23,221.2A16,16,0,0,1,32,192H192.38l48.4-148.95a16,16,0,0,1,30.44,0l48.4,149H480a16,16,0,0,1,9.05,29.2L359,310.35l50.13,148.53A16,16,0,0,1,394,480Z" ]
            []
        ]

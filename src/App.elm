module App exposing (init)

import Browser.Navigation as Nav
import Data exposing (..)
import Routes
import Url
import Utils exposing (toBp)


model : Int -> Int -> Route -> Url.Url -> Nav.Key -> Model
model width height route url key =
    { key = key
    , url = url
    , bp = toBp width
    , route = route
    , width = width
    , height = height
    , adjust =
        { f1 = 5.6
        , f2 = 7.7
        , f3 = -3.5
        , f4 = 10
        }
    , title = "Model Y checklist"
    , checklist = checklist
    }


checklist : List ChecklistItem
checklist =
    [ { section = "Pre-delivery records"
      , title = "Name & Address"
      , description = " Check for the correct full name and address on your paperwork."
      , img = Nothing
      , completed = False
      , id = 0
      }
    ]


init : ( Int, Int ) -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init wh url key =
    ( model (Tuple.first wh) (Tuple.second wh) (Routes.parse url) url key, Cmd.none )

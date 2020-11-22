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
    , issues = []
    }


checklist : List ChecklistItem
checklist =
    [ { section = "Pre-delivery records"
      , title = "Name & Address"
      , description = " Check for the correct full name and address on your paperwork."
      , maybeImg =
            Just
                { src = "https://electrek.co/wp-content/uploads/sites/3/2020/04/Screen-Shot-2020-04-27-at-9.39.15-PM.jpg?quality=82&strip=all&w=1000"
                , description = "Missaligned wheelwell trim"
                }
      , completed = False
      , id = 0
      }
    , { maybeImg = Nothing
      , section = "Front"
      , title = "Headlight"
      , description = "Check the head light fit"
      , completed = False
      , id = 1
      }
    , { maybeImg = Nothing
      , section = "Front"
      , title = "Front bumper"
      , description = "Inspect the paint around intake vents on the front bumper"
      , completed = False
      , id = 2
      }
    , { maybeImg = Nothing
      , section = "Front"
      , title = "Frunk"
      , description = "Inspect the frunk, look for paint defects, dents and signs of improper closing by the sides of the T logo"
      , completed = False
      , id = 3
      }
    , { maybeImg = Nothing
      , section = "Front"
      , title = "Hood"
      , description = "Make sure the hood sits flush with the quarter panels and frunk"
      , completed = False
      , id = 4
      }
    , { maybeImg = Nothing
      , section = "Front"
      , title = "Windshield"
      , description = "Inspect that the windshield isn't installed shifted (the gaps between the glass and A pillar on either side should be approximately equal). An improperly installed windshield causes significant wind noise at highway speeds."
      , completed = False
      , id = 5
      }
    , { maybeImg = Nothing
      , section = "Body"
      , title = "Body"
      , description = "Check for uneven/wide panel gaps and that panels are flush to car"
      , completed = False
      , id = 6
      }
    , { maybeImg = Nothing
      , section = "Body"
      , title = "Trim"
      , description = "Check for trim stains"
      , completed = False
      , id = 7
      }
    , { maybeImg = Nothing
      , section = "Body"
      , title = "Door"
      , description = "Check all 4 door levers"
      , completed = False
      , id = 8
      }
    , { maybeImg = Nothing
      , section = "Wheels"
      , title = "Wheels"
      , description = "Check all wheels, make sure they aren’t scratched"
      , completed = False
      , id = 9
      }
    , { maybeImg = Nothing
      , section = "Wheels"
      , title = "Hubcaps"
      , description = "Confirm all 4 hubcaps are present and properly attached"
      , completed = False
      , id = 10
      }
    , { maybeImg = Nothing
      , section = "Body"
      , title = "Pillars"
      , description = "Check for dings on pillars"
      , completed = False
      , id = 11
      }
    , { maybeImg = Nothing
      , section = "Body"
      , title = "Paint"
      , description = "Inspect the paint on the outside and the door jams, ensure panel corners do not have chips"
      , completed = False
      , id = 12
      }
    , { maybeImg = Nothing
      , section = "Body"
      , title = "Rocker pannels"
      , description = "Check for damage to black rocker panels"
      , completed = False
      , id = 13
      }
    , { maybeImg = Nothing
      , section = "Back"
      , title = "Tail light"
      , description = "Check the tail light fit"
      , completed = False
      , id = 14
      }
    ]


init : ( Int, Int ) -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init wh url key =
    ( model (Tuple.first wh) (Tuple.second wh) (Routes.parse url) url key, Cmd.none )

module Data exposing (BreakPoint(..), ChecklistItem, ChecklistState(..), Issue, Model, Msg(..), Route(..))

import Browser
import Browser.Navigation as Nav
import Element.Region exposing (description)
import Http
import Url


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , width : Int
    , height : Int
    , bp : BreakPoint
    , route : Route
    , title : String
    , adjust : Adjust
    , checkliststate : ChecklistState
    , checklist : List ChecklistItem
    , issues : List Issue
    , cursor : Int
    }


type ChecklistState
    = Getting
    | UnableToLoad
    | GotChecklist


type alias Issue =
    { checklistId : Int
    , comment : Maybe String
    }


type alias ChecklistItem =
    { title : String
    , description : String
    , maybeImg :
        Maybe
            { src : String
            , description : String
            }
    , ok : Bool
    , completed : Bool
    , id : Int
    }


type alias Adjust =
    { f1 : Float
    , f2 : Float
    , f3 : Float
    , f4 : Float
    }


type Route
    = Home
    | Checklist
    | NotFound


type BreakPoint
    = XS Int
    | SM
    | MD
    | LG
    | XL


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | DimensionChange Int Int
    | AdjustF Int Float
    | ChecklistLoaded (Result Http.Error (List ChecklistItem))
    | HandleItem Int (Maybe Issue)
    | GoTo Int
    | NoOp

module Data exposing (BreakPoint(..), ChecklistItem, Model, Msg(..), Route(..))

import Browser
import Browser.Navigation as Nav
import Element.Region exposing (description)
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
    , checklist : List ChecklistItem
    }


type alias ChecklistItem =
    { section : String
    , title : String
    , description : String
    , img : Maybe String
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
    | NoOp

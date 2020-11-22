module App.Home exposing (..)

import Data exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font


ot : Model -> String
ot m =
    let
        bp =
            case m.bp of
                XS _ ->
                    "xs"

                SM ->
                    "sm"

                MD ->
                    "MD"

                LG ->
                    "LG"

                XL ->
                    "XL"
    in
    bp ++ ":" ++ String.fromInt m.width


home : Model -> Element Msg
home m =
    el [ Border.glow (rgb 0 0 100) 1, width fill, height fill ] (text (ot m))

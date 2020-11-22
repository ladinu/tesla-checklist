module Routes exposing (parse, toStr, updateUrl)

import Browser
import Browser.Navigation as Nav
import Data exposing (..)
import Url
import Url.Parser


toStr : Route -> String
toStr r =
    case r of
        Home ->
            ""

        Checklist ->
            "checklist"

        NotFound ->
            "not-found"


parse : Url.Url -> Route
parse url =
    let
        routeParser : Url.Parser.Parser (Route -> a) a
        routeParser =
            Url.Parser.oneOf
                [ Url.Parser.map Home Url.Parser.top
                , Url.Parser.map Checklist (Url.Parser.s (toStr Checklist))
                ]
    in
    Maybe.withDefault NotFound (Url.Parser.parse routeParser url)


updateUrl : Msg -> Model -> ( Model, Cmd Msg )
updateUrl msg m =
    case msg of
        LinkClicked req ->
            case req of
                Browser.Internal url ->
                    let
                        nm =
                            { m
                                | url = url
                                , route = parse url
                            }
                    in
                    ( nm, Nav.pushUrl m.key (Url.toString url) )

                Browser.External href ->
                    ( m, Nav.load href )

        UrlChanged url ->
            let
                nm =
                    { m
                        | url = url
                        , route = parse url
                    }
            in
            ( nm, Cmd.none )

        _ ->
            ( m, Cmd.none )

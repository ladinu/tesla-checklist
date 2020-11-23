module Main exposing (main)

import App
import App.Home exposing (home)
import App.Logic
import App.Page exposing (page)
import Browser
import Browser.Events
import Data exposing (..)
import Routes
import Utils exposing (toBp)


main : Program ( Int, Int ) Model Msg
main =
    Browser.application
        { init = App.init
        , subscriptions = \_ -> Browser.Events.onResize DimensionChange
        , update = update
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        , view = view
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg m =
    case msg of
        LinkClicked req ->
            Routes.updateUrl (LinkClicked req) m

        UrlChanged url ->
            Routes.updateUrl (UrlChanged url) m

        DimensionChange w h ->
            ( { m | width = w, height = h, bp = toBp w }, Cmd.none )

        HandleItem id maybeIssue ->
            ( App.Logic.handleItem m id maybeIssue, Cmd.none )

        AdjustF f v ->
            let
                adjusted adjust =
                    if f == 1 then
                        { adjust | f1 = v }

                    else if f == 2 then
                        { adjust | f2 = v }

                    else if f == 3 then
                        { adjust | f3 = v }

                    else
                        { adjust | f4 = v }
            in
            ( { m | adjust = adjusted m.adjust }, Cmd.none )

        ChecklistLoaded (Err e) ->
            ( { m | checklist = [], checkliststate = UnableToLoad }, Cmd.none )

        ChecklistLoaded (Ok list) ->
            ( { m | checklist = list, checkliststate = GotChecklist }, Cmd.none )

        NoOp ->
            ( m, Cmd.none )


view : Model -> Browser.Document Msg
view m =
    { title = m.title
    , body =
        case m.route of
            Home ->
                page home m

            _ ->
                page home m
    }

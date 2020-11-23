module App.Logic exposing (..)

import Data exposing (..)
import Element.Region exposing (description)
import Http
import Json.Decode as D
import Svg exposing (desc)


checklistStarted : Model -> Bool
checklistStarted m =
    not <| checklistNotStarted m


checklistNotStarted : Model -> Bool
checklistNotStarted m =
    List.all (\a -> a == False) <| (List.map .completed <| m.checklist)


checklistLoading : Model -> Bool
checklistLoading m =
    case m.checkliststate of
        Getting ->
            True

        _ ->
            False


checklistError : Model -> Bool
checklistError m =
    case m.checkliststate of
        UnableToLoad ->
            True

        _ ->
            False


onHome : Model -> Bool
onHome m =
    case m.route of
        Home ->
            True

        _ ->
            False


onChecklist : Model -> Bool
onChecklist m =
    case m.route of
        Checklist ->
            True

        _ ->
            False


checklistProgress : Model -> ( Int, Int )
checklistProgress m =
    List.partition .completed m.checklist
        |> Tuple.mapBoth List.length List.length


getNextChecklistItem : Model -> Maybe ChecklistItem
getNextChecklistItem m =
    List.partition .completed m.checklist
        |> Tuple.second
        |> List.head


handleItem : Model -> Int -> Maybe Issue -> Model
handleItem m id maybeIssue =
    let
        newList =
            m.checklist
                |> List.map
                    (\i ->
                        if i.id == id then
                            { i | completed = True }

                        else
                            i
                    )

        newm =
            { m | checklist = newList }
    in
    case maybeIssue of
        Just ok ->
            newm

        Nothing ->
            newm


loadChecklistCmd : Cmd Msg
loadChecklistCmd =
    Http.get
        { url = "/data.json"
        , expect = Http.expectJson ChecklistLoaded checklistDecoder
        }


type alias Tmp =
    { title : String
    , desc : String
    , img : Maybe String
    }


checklistDecoder : D.Decoder (List ChecklistItem)
checklistDecoder =
    let
        toChecklistItem i tmp =
            { title = tmp.title
            , description = tmp.desc
            , maybeImg = Maybe.map (\src -> { src = src, description = "" }) tmp.img
            , completed = False
            , id = i
            }

        maptoItems rawItems =
            List.indexedMap toChecklistItem rawItems
    in
    D.map maptoItems <|
        D.list <|
            D.map3 Tmp
                (D.field "title" D.string)
                (D.field "desc" D.string)
                (D.maybe (D.field "img" D.string))

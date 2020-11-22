module App.Logic exposing (..)

import Data exposing (..)


checklistStarted : Model -> Bool
checklistStarted m =
    not <| checklistNotStarted m


checklistNotStarted : Model -> Bool
checklistNotStarted m =
    List.all (\a -> a == False) <| (List.map .completed <| m.checklist)


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

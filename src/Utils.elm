module Utils exposing (..)

import Data exposing (..)


toBp : Int -> BreakPoint
toBp width =
    if width < 576 then
        XS width

    else if width < 768 then
        SM

    else if width < 992 then
        MD

    else if width < 1200 then
        LG

    else
        XL


bpw : BreakPoint -> Int
bpw bp =
    case bp of
        XS w ->
            w

        SM ->
            540

        MD ->
            720

        LG ->
            960

        XL ->
            1140


grouped : List a -> Int -> List (List a)
grouped list c =
    let
        go acc i lst =
            let
                k =
                    List.take c (List.drop i lst)
            in
            case k of
                [] ->
                    acc

                _ ->
                    k :: go acc (c + i) lst
    in
    go [] 0 list

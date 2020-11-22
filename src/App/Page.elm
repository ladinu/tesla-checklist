module App.Page exposing (page)

import App.Logic
import Assets exposing (menu, star)
import Data exposing (..)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Input as Input
import Element.Region exposing (description)
import Html exposing (Html)
import Html.Attributes exposing (title)
import Palette exposing (gray9)
import Routes
import Scale exposing (..)
import Utils exposing (bpw)


page : (Model -> Element Msg) -> Model -> List (Html Msg)
page content m =
    [ Element.layout [] (tst m)
    ]


hl : Attribute msg
hl =
    hlf 0.15


hlf : Float -> Attribute msg
hlf f =
    Background.color <| hlColor f


hlColor : Float -> Color
hlColor f =
    rgba255 86 61 124 f


container : Model -> List (Attribute msg) -> Element msg -> Element msg
container m attrs inner =
    case m.bp of
        XS _ ->
            row attrs
                [ column [ width fill, height fill ]
                    [ inner
                    ]
                ]

        _ ->
            let
                side =
                    column
                        [ height fill
                        , width fill
                        ]
                        []
            in
            row attrs
                [ side
                , column [ width <| px (bpw m.bp), height fill ]
                    [ inner
                    ]
                , side
                ]


nav : Model -> Element msg -> Element msg
nav m other =
    row
        [ width fill
        , height fill
        , padding s4
        ]
        [ image [ height <| px 55 ]
            { src = "imgsrc"
            , description = "Tesla Model Y delivery checklist"
            }
        , other
        ]


edges : { top : Int, bottom : Int, left : Int, right : Int }
edges =
    { top = 0
    , bottom = 0
    , left = 0
    , right = 0
    }


add : List a -> List a -> List a
add a b =
    b ++ a


with : a -> List a -> List a
with a b =
    b ++ [ a ]


topAndRest : Int -> Int -> { top : Int, bottom : Int, left : Int, right : Int }
topAndRest a b =
    { edges | top = a, bottom = b, left = b, right = b }


mapFirstAndRest : List a -> (a -> b) -> (a -> b) -> List b
mapFirstAndRest items firstFunc restFunc =
    (items
        |> List.take 1
        |> List.map firstFunc
    )
        ++ (items
                |> List.drop 1
                |> List.map restFunc
           )


bg : Model -> Attribute msg
bg m =
    Background.color <| rgba255 255 255 255 0


isBelowMD : Model -> Bool
isBelowMD m =
    case m.bp of
        SM ->
            True

        XS _ ->
            True

        _ ->
            False


isBelowLG : Model -> Bool
isBelowLG m =
    case m.bp of
        XS _ ->
            True

        SM ->
            True

        MD ->
            True

        _ ->
            False


sliders m =
    let
        min =
            -100

        max =
            100

        step =
            0.001
    in
    column
        [ width fill
        , paddingEach { edges | top = s10 }
        ]
        [ Input.slider
            [ Element.behindContent
                (Element.el
                    [ Element.width Element.fill
                    , Element.height (Element.px 2)
                    , Element.centerY
                    , Background.color Palette.gray3
                    , Border.rounded 2
                    ]
                    Element.none
                )
            ]
            { onChange = AdjustF 1
            , label = Input.labelLeft [] (text "f1")
            , min = min
            , max = max
            , step = Just step
            , thumb = Input.defaultThumb
            , value = m.adjust.f1
            }
        , Input.slider
            [ Element.behindContent
                (Element.el
                    [ Element.width Element.fill
                    , Element.height (Element.px 2)
                    , Element.centerY
                    , Background.color Palette.gray3
                    , Border.rounded 2
                    ]
                    Element.none
                )
            ]
            { onChange = AdjustF 2
            , label = Input.labelLeft [] (text "f2")
            , min = min
            , max = max
            , step = Just step
            , thumb = Input.defaultThumb
            , value = m.adjust.f2
            }
        , Input.slider
            [ Element.behindContent
                (Element.el
                    [ Element.width Element.fill
                    , Element.height (Element.px 2)
                    , Element.centerY
                    , Background.color Palette.gray3
                    , Border.rounded 2
                    ]
                    Element.none
                )
            ]
            { onChange = AdjustF 3
            , label = Input.labelLeft [] (text "f3")
            , min = min
            , max = max
            , step = Just step
            , thumb = Input.defaultThumb
            , value = m.adjust.f3
            }
        , Input.slider
            [ Element.behindContent
                (Element.el
                    [ Element.width Element.fill
                    , Element.height (Element.px 2)
                    , Element.centerY
                    , Background.color Palette.gray3
                    , Border.rounded 2
                    ]
                    Element.none
                )
            ]
            { onChange = AdjustF 4
            , label = Input.labelLeft [] (text "f4")
            , min = min
            , max = max
            , step = Just step
            , thumb = Input.defaultThumb
            , value = m.adjust.f4
            }
        ]


sliderNums m =
    column []
        [ text ("f1: " ++ String.fromFloat m.adjust.f1)
        , text ("f2: " ++ String.fromFloat m.adjust.f2)
        , text ("f3: " ++ String.fromFloat m.adjust.f3)
        , text ("f4: " ++ String.fromFloat m.adjust.f4)
        ]


begin : Model -> Element Msg
begin m =
    let
        ( completed, notCompleted ) =
            App.Logic.checklistProgress m

        total =
            completed + notCompleted

        buttonText =
            if completed == 0 then
                "Begin"

            else if completed < total then
                "Continue"

            else
                "Export"
    in
    column [ width fill, height fill ]
        [ column [ Element.centerX, Element.centerY, spacing s3 ]
            [ row [] [ text (String.fromInt completed ++ "/" ++ String.fromInt total ++ " completed") ]
            , Element.link
                [ Element.centerX
                , padding s1
                , Background.color (hlColor 2)
                , height (px s8)
                , width (px s12)
                , Border.rounded s1
                ]
                { url = Routes.toStr Checklist
                , label = el [ Element.centerX ] (text buttonText)
                }
            ]
        ]


checklistV : Model -> Element Msg
checklistV m =
    let
        cp =
            s1
    in
    case App.Logic.getNextChecklistItem m of
        Just { title, section, maybeImg, description, id } ->
            column
                [ width fill
                , height fill
                ]
                [ row [ width fill, height (fillPortion 1) ] []
                , row [ width fill, height (fillPortion 8) ]
                    [ column [ height fill, width (fillPortion 1) ] []
                    , column
                        [ height fill
                        , width (fillPortion 8)
                        , Background.color (rgba255 255 255 255 255)
                        , Border.rounded s1
                        ]
                        [ paragraph
                            [ padding cp
                            , height (fillPortion 2)
                            , width fill
                            ]
                            [ text title ]
                        , case maybeImg of
                            Just img ->
                                image
                                    [ width fill
                                    , height (fillPortion 3)
                                    , padding cp
                                    ]
                                    img

                            Nothing ->
                                none
                        , paragraph
                            [ padding cp
                            , height (fillPortion 3)
                            , width fill
                            ]
                            [ text description ]
                        , row
                            [ height (fillPortion 2)
                            , width fill
                            , spacing s3
                            , padding s3
                            ]
                            [ column
                                [ width (fillPortion 1)
                                , height fill
                                ]
                                [ row
                                    [ Background.color (hlColor 1)
                                    , width fill
                                    , height fill
                                    , Element.Events.onClick (HandleItem id (Just { checklistId = id, comment = Nothing }))
                                    ]
                                    [ el
                                        [ centerY
                                        , centerX
                                        ]
                                        (text "X")
                                    ]
                                ]
                            , column
                                [ width (fillPortion 1)
                                , height fill
                                ]
                                [ row
                                    [ Background.color (hlColor 1)
                                    , width fill
                                    , height fill
                                    , Element.Events.onClick (HandleItem id Nothing)
                                    ]
                                    [ el
                                        [ centerY
                                        , centerX
                                        ]
                                        (text "✓")
                                    ]
                                ]
                            ]
                        ]
                    , column [ height fill, width (fillPortion 1) ] []
                    ]
                , row [ width fill, height (fillPortion 1) ] []
                ]

        Nothing ->
            link []
                { url = Routes.toStr Home
                , label = text "Done!"
                }


tst : Model -> Element Msg
tst m =
    column
        [ width fill
        , height fill
        , bg m

        -- , Background.color reviewbg
        , Font.family
            [ Font.typeface "PT Sans"
            , Font.sansSerif
            ]
        ]
        [ container m
            [ hl
            , width fill
            , height fill
            ]
          <|
            column
                [ width fill
                , height fill
                ]
                (if App.Logic.onHome m then
                    [ begin m ]

                 else if App.Logic.onChecklist m then
                    [ checklistV m ]

                 else
                    [ row [ width fill ] [ text "r0" ]
                    , row [ width fill ] [ text "r1" ]
                    , row [ width fill ] [ text "r2" ]
                    ]
                )
        ]

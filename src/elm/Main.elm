module Main exposing (..)

-- IMPORTS ---------------------------------------------------------------------

import Browser
import Data.IO exposing (IO)
import Html exposing (Html)
import Html.Attributes
import Page.Landing
import Svg
import Svg.Attributes



-- MAIN ------------------------------------------------------------------------


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- MODEL -----------------------------------------------------------------------


type alias Model =
    { landing : Page.Landing.Model }


type alias Flags =
    ()


init : Flags -> IO Msg Model
init _ =
    Page.Landing.init ()
        |> Data.IO.mapCmd (Update << Landing)
        |> Data.IO.map Model



-- UPDATE ----------------------------------------------------------------------


type Msg
    = None
    | Update Page


type Page
    = Landing Page.Landing.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            Data.IO.pure model

        Update (Landing pageMsg) ->
            Page.Landing.update pageMsg model.landing
                |> Data.IO.mapCmd (Update << Landing)
                |> Data.IO.map (\landing -> { model | landing = landing })



-- VIEW ------------------------------------------------------------------------


view : Model -> Browser.Document Msg
view model =
    Browser.Document "Ren – Cleaner, clearer JavaScript."
        [ viewHeader
        , Page.Landing.view model.landing
            |> Html.map (Update << Landing)
        , viewFooter
        ]


viewHeader : Html Msg
viewHeader =
    Html.nav
        [ Html.Attributes.class "fixed z-50 w-full"
        , Html.Attributes.class "px-12 py-8"
        , Html.Attributes.class "bg-white shadow-lg"
        ]
        [ Html.ul
            [ Html.Attributes.class "flex flex-row space-x-12"
            , Html.Attributes.class "text-ren-dark-blue-700 text-xl"
            ]
            [ Html.li
                []
                [ Html.a
                    [ Html.Attributes.href "#"
                    , Html.Attributes.class "bg-ren-orange-500 bg-opacity-0 hover:bg-opacity-100"
                    , Html.Attributes.class "transition-all duration-150 ease-in-out"
                    , Html.Attributes.class "px-2 py-1 rounded"
                    , Html.Attributes.class "font-bold hover:text-gray-50"
                    ]
                    [ Html.text "Ren" ]
                ]
            , Html.li []
                [ Html.a
                    [ Html.Attributes.href "#"
                    , Html.Attributes.class "bg-ren-dark-blue-500 bg-opacity-0 hover:bg-opacity-100"
                    , Html.Attributes.class "transition-all duration-150 ease-in-out"
                    , Html.Attributes.class "px-2 py-1 rounded"
                    , Html.Attributes.class "hover:text-gray-50"
                    ]
                    [ Html.text "play" ]
                ]
            , Html.li []
                [ Html.a
                    [ Html.Attributes.href "#"
                    , Html.Attributes.class "bg-ren-dark-blue-500 bg-opacity-0 hover:bg-opacity-100"
                    , Html.Attributes.class "transition-all duration-150 ease-in-out"
                    , Html.Attributes.class "px-2 py-1 rounded"
                    , Html.Attributes.class "hover:text-gray-50"
                    ]
                    [ Html.text "docs" ]
                ]
            , Html.li []
                [ Html.a
                    [ Html.Attributes.href "#"
                    , Html.Attributes.class "bg-ren-dark-blue-500 bg-opacity-0 hover:bg-opacity-100"
                    , Html.Attributes.class "transition-all duration-150 ease-in-out"
                    , Html.Attributes.class "px-2 py-1 rounded"
                    , Html.Attributes.class "hover:text-gray-50"
                    ]
                    [ Html.text "blog" ]
                ]
            , Html.li []
                [ Html.a
                    [ Html.Attributes.href "#"
                    , Html.Attributes.class "bg-ren-dark-blue-500 bg-opacity-0 hover:bg-opacity-100"
                    , Html.Attributes.class "transition-all duration-150 ease-in-out"
                    , Html.Attributes.class "px-2 py-1 rounded"
                    , Html.Attributes.class "hover:text-gray-50"
                    ]
                    [ Html.text "support" ]
                ]
            ]
        ]


viewFooter : Html Msg
viewFooter =
    Html.footer
        [ Html.Attributes.class "bg-ren-dark-blue-800" ]
        []



-- SUBSCRIPTIONS ---------------------------------------------------------------


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        []

module UI.Text exposing (..)

import Html exposing (Html)
import Html.Attributes


emphasis : ( String, String ) -> String -> Html msg
emphasis ( from, to ) text =
    Html.span
        [ Html.Attributes.class "inline-block"
        , Html.Attributes.class "font-bold text-transparent"
        , Html.Attributes.class "bg-gradient-to-r bg-clip-text"
        , Html.Attributes.class <| "from-" ++ from
        , Html.Attributes.class <| "to-" ++ to
        ]
        [ Html.text text ]

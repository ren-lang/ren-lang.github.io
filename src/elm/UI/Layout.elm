module UI.Layout exposing (..)

-- IMPORTS ---------------------------------------------------------------------

import Html exposing (Html)
import Html.Attributes



-- STACK -----------------------------------------------------------------------


stack : List (Html.Attribute msg) -> List (Html msg) -> Html msg
stack attrs children =
    Html.div
        (Html.Attributes.class "flex flex-col justify-start"
            :: attrs
        )
        children

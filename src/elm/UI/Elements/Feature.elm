module UI.Elements.Feature exposing (..)

-- IMPORTS ---------------------------------------------------------------------

import Html exposing (Html)
import Html.Attributes
import UI.Components.CodeFlask


type Aside
    = Left
    | Right


codeFeature : ( Aside, String, String ) -> List (Html.Attribute msg) -> List (Html msg) -> Html msg
codeFeature ( aside, lang, src ) attrs content =
    Html.article
        (Html.Attributes.class "flex flex-col lg:flex-row items-center w-4/5" :: attrs)
        (case aside of
            Left ->
                [ UI.Components.CodeFlask.view src
                    [ UI.Components.CodeFlask.readonly True
                    , UI.Components.CodeFlask.language lang
                    , Html.Attributes.class "flex-1 mr-8 h-64 rounded shadow"
                    ]
                , Html.div
                    [ Html.Attributes.class "flex-1 ml-8 " ]
                    content
                ]

            Right ->
                [ Html.div
                    [ Html.Attributes.class "flex-1 mr-8 " ]
                    content
                , UI.Components.CodeFlask.view src
                    [ UI.Components.CodeFlask.readonly True
                    , UI.Components.CodeFlask.language lang
                    , Html.Attributes.class "flex-1 ml-8 h-72 rounded shadow"
                    ]
                ]
        )

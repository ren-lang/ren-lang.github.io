module Page.Landing exposing (..)

-- IMPORTS ---------------------------------------------------------------------

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Ren.Compiler exposing (Target(..))
import Svg
import Svg.Attributes
import UI.Components.CodeFlask
import UI.Elements.Feature exposing (Aside(..))
import UI.Text



-- MODEL -----------------------------------------------------------------------


type alias Model =
    { input : String
    }


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { input = String.trim """
// Better exaple pending...
enum Person
    = #teacher
    | #director
    | #student _

pub fun greeting = person =>
    when person 
        is #teacher => 'Hey, professor!'
        is #director => 'Hello director.'
        is #student 'Richard' => 'Still here Ricky?!'
        is #student name => `Hey ${name}.`
        """
      }
    , Cmd.none
    )



-- UPDATE ----------------------------------------------------------------------


type Msg
    = Typed Input String


type Input
    = Editor


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Typed Editor input ->
            ( { model | input = input }
            , Cmd.none
            )



-- VIEW ------------------------------------------------------------------------


view : Model -> Html Msg
view model =
    Html.main_ []
        [ viewSectionIntro model
        , viewSectionFeatures
        ]



-- VIEW SECTION: INTRO ---------------------------------------------------------


viewSectionIntro : Model -> Html Msg
viewSectionIntro model =
    Html.section
        [ Html.Attributes.class "min-h-screen relative"
        , Html.Attributes.class "bg-gray-50"
        , Html.Attributes.class "py-32"
        , Html.Attributes.class "flex flex-col items-center justify-center space-y-24"
        ]
        [ Html.div
            [ Html.Attributes.class "mx-auto text-center space-y-8 px-4" ]
            [ viewTagline
            , viewSubheading
            ]
        , Html.p
            [ Html.Attributes.class "mx-auto text-justify max-w-prose px-8" ]
            [ Html.text <|
                "Ren is a functional, immutable-by-default, dynamically typed "
                    ++ "scripting language. Combining productive functional "
                    ++ "features such as tagged unions and pattern matching "
                    ++ "with the freedom of JavaScript, Ren strikes a pragmatic "
                    ++ "balance between safety and flexibility."
            ]
        , viewExampleEditors model.input
        , viewWaves
        ]


viewTagline : Html msg
viewTagline =
    Html.h1
        [ Html.Attributes.class "text-6xl" ]
        [ UI.Text.emphasis ( "ren-pink-600", "ren-orange-500" )
            "Cleaner, clearer JavaScript."
        ]


viewSubheading : Html msg
viewSubheading =
    Html.h2
        [ Html.Attributes.class "inline-block"
        , Html.Attributes.class "text-5xl font-bold text-ren-dark-blue-700"
        , Html.Attributes.class "group hover:text-gray-300"
        , Html.Attributes.class "transition duration-150 ease-in-out"
        ]
        [ Html.text "A modern scripting language for the"
        , Html.span
            [ Html.Attributes.class "text-ren-dark-blue-700 bg-ren-dark-blue-500 bg-opacity-0"
            , Html.Attributes.class "px-2 mx-1 rounded"
            , Html.Attributes.class "xl:group-hover:text-gray-50"
            , Html.Attributes.class "xl:group-hover:bg-opacity-100"
            , Html.Attributes.class "transition-all duration-150 ease-in-out"
            ]
            [ Html.text "modern Web." ]
        ]


viewExampleEditors : String -> Html Msg
viewExampleEditors renInput =
    let
        jsOutput =
            Ren.Compiler.compile renInput
                |> Result.withDefault ""
                |> String.trim
    in
    Html.div
        [ Html.Attributes.class "z-10 h-64 w-2/3 relative bg-gray-50"
        , Html.Attributes.class "hidden md:flex flex-row"
        , Html.Attributes.class "shadow-xl"
        ]
        [ Html.div
            [ Html.Attributes.class "flex-1 flex flex-col" ]
            [ UI.Components.CodeFlask.view renInput
                [ Html.Attributes.class "flex-1"
                , Html.Attributes.class "border border-r"
                , Html.Events.onInput (Typed Editor)
                , UI.Components.CodeFlask.language "ren"
                ]
            , Html.span
                [ Html.Attributes.class "w-full py-1 bg-ren-dark-blue-500"
                , Html.Attributes.class "text-white text-xs text-center"
                ]
                [ Html.text "Ren in." ]
            ]
        , Html.div
            [ Html.Attributes.class "flex-1 flex flex-col" ]
            [ UI.Components.CodeFlask.view jsOutput
                [ Html.Attributes.class "flex-1"
                , Html.Attributes.class "border border-l"
                , UI.Components.CodeFlask.readonly True
                , UI.Components.CodeFlask.language "javascript"
                ]
            , Html.span
                [ Html.Attributes.class "w-full py-1 bg-ren-dark-blue-500"
                , Html.Attributes.class "text-white text-xs text-center"
                ]
                [ Html.text "JavaScript out." ]
            ]
        ]


viewWaves : Html msg
viewWaves =
    let
        a =
            "M0,32L80,80C160,128,320,224,480,218.7C640,213,800,107,960,74.7C1120,43,1280,85,1360,106.7L1440,128L1440,320L1360,320C1280,320,1120,320,960,320C800,320,640,320,480,320C320,320,160,320,80,320L0,320Z"

        b =
            "M0,192L30,192C60,192,120,192,180,186.7C240,181,300,171,360,144C420,117,480,75,540,64C600,53,660,75,720,74.7C780,75,840,53,900,85.3C960,117,1020,203,1080,245.3C1140,288,1200,288,1260,266.7C1320,245,1380,203,1410,181.3L1440,160L1440,320L1410,320C1380,320,1320,320,1260,320C1200,320,1140,320,1080,320C1020,320,960,320,900,320C840,320,780,320,720,320C660,320,600,320,540,320C480,320,420,320,360,320C300,320,240,320,180,320C120,320,60,320,30,320L0,320Z"

        c =
            "M0,224L60,202.7C120,181,240,139,360,138.7C480,139,600,181,720,170.7C840,160,960,96,1080,64C1200,32,1320,32,1380,32L1440,32L1440,320L1380,320C1320,320,1200,320,1080,320C960,320,840,320,720,320C600,320,480,320,360,320C240,320,120,320,60,320L0,320Z"
    in
    Html.div
        [ Html.Attributes.class "absolute bottom-0 left-0"
        , Html.Attributes.class "w-full"
        ]
        [ Svg.svg
            [ Svg.Attributes.viewBox "0 0 1400 320"
            , Svg.Attributes.class "absolute bottom-0 left-0"
            , Svg.Attributes.class "fill-current opacity-80"
            , Svg.Attributes.width "100%"
            ]
            [ Svg.defs []
                [ Svg.linearGradient
                    [ Svg.Attributes.id "orange-to-blue"
                    , Svg.Attributes.x1 "0%"
                    , Svg.Attributes.y1 "0%"
                    , Svg.Attributes.x2 "0%"
                    , Svg.Attributes.y2 "95%"
                    ]
                    [ Svg.stop
                        [ Svg.Attributes.offset "0%"
                        , Svg.Attributes.stopColor "#EA9D85"
                        , Svg.Attributes.stopOpacity "1"
                        ]
                        []
                    , Svg.stop
                        [ Svg.Attributes.offset "30%"
                        , Svg.Attributes.stopColor "#DD5E36"
                        , Svg.Attributes.stopOpacity "100%"
                        ]
                        []
                    , Svg.stop
                        [ Svg.Attributes.offset "100%"
                        , Svg.Attributes.stopColor "#343B73"
                        , Svg.Attributes.stopOpacity "100%"
                        ]
                        []
                    ]
                ]
            , Svg.path
                [ Svg.Attributes.fill "url(#orange-to-blue)"
                , Svg.Attributes.d a
                ]
                []
            ]
        , Svg.svg
            [ Svg.Attributes.viewBox "0 0 1400 320"
            , Svg.Attributes.class "absolute bottom-0 left-0"
            , Svg.Attributes.class "fill-current"
            , Svg.Attributes.width "100%"
            ]
            [ Svg.defs []
                [ Svg.linearGradient
                    [ Svg.Attributes.id "orange-to-blue"
                    , Svg.Attributes.x1 "0%"
                    , Svg.Attributes.y1 "0%"
                    , Svg.Attributes.x2 "0%"
                    , Svg.Attributes.y2 "95%"
                    ]
                    [ Svg.stop
                        [ Svg.Attributes.offset "0%"
                        , Svg.Attributes.stopColor "#E27BA5"
                        , Svg.Attributes.stopOpacity "1"
                        ]
                        []
                    , Svg.stop
                        [ Svg.Attributes.offset "30%"
                        , Svg.Attributes.stopColor "#DD5E36"
                        , Svg.Attributes.stopOpacity "100%"
                        ]
                        []
                    , Svg.stop
                        [ Svg.Attributes.offset "100%"
                        , Svg.Attributes.stopColor "#242950"
                        , Svg.Attributes.stopOpacity "100%"
                        ]
                        []
                    ]
                ]
            , Svg.path
                [ Svg.Attributes.fill "url(#orange-to-blue)"
                , Svg.Attributes.d b
                ]
                []
            ]
        ]



-- VIEW SECTION: FEATURES ------------------------------------------------------


viewSectionFeatures : Html msg
viewSectionFeatures =
    Html.section
        [ Html.Attributes.class "bg-ren-dark-blue-500"
        , Html.Attributes.class "py-32"
        , Html.Attributes.class "space-y-32"
        , Html.Attributes.class "flex flex-col items-center"
        ]
        [ viewNoNPMFeature
        , viewNoTypesFeature
        , viewTestsFeature
        ]


viewNoNPMFeature : Html msg
viewNoNPMFeature =
    let
        src =
            String.trim """
<head>
  <script type="module" src="https://cdn.skypack.dev/ren-lang/compiler"></script>
  <script type="application/ren">
    pub fun main _ => {
      let platforms = [ 'npm', 'playgound', 'html' ]

      ret Array.map (fun platform => `Hello from ${platform}`) platforms
    }
  </script>
</head>
"""
    in
    UI.Elements.Feature.codeFeature ( Right, "html", src )
        []
        [ Html.h2
            [ Html.Attributes.class "text-gray-50 text-4xl"
            , Html.Attributes.class "mb-4"
            ]
            [ Html.text "Install from npm, "
            , UI.Text.emphasis ( "ren-pink-500", "ren-pink-600" )
                "or don't"
            , Html.text "."
            ]
        , Html.p
            [ Html.Attributes.class "text-white text-lg" ]
            [ Html.text <|
                "Drop a single script tag in your HTML and start writing "
                    ++ "Ren immediately. Prefer npm? You can find us there "
                    ++ "too."
            ]
        ]


viewNoTypesFeature : Html msg
viewNoTypesFeature =
    let
        src =
            String.trim """
pub fun calculateArea = value =>
    when value
        // Runtime type checking
        is @Number n => n
        // Tagged variants
        is #circle r => Math.pi * r^2
        is #square s => s^2
        // Destructuring
        is [ x, y, z ] => x * y * z
        // Combining patterns
        is { getArea: @Function f } => f ()
"""
    in
    UI.Elements.Feature.codeFeature ( Left, "ren", src )
        []
        [ Html.h2
            [ Html.Attributes.class "text-gray-50 text-4xl"
            , Html.Attributes.class "mb-4"
            ]
            [ Html.text "No types? "
            , UI.Text.emphasis ( "ren-yellow-400", "ren-orange-400" )
                "No problem"
            , Html.text "."
            ]
        , Html.p
            [ Html.Attributes.class "text-white text-lg" ]
            [ Html.text <|
                "Powerful pattern matching gives you the tools to handle "
                    ++ "dynamic code effortlessly."
            ]
        ]


viewTestsFeature : Html msg
viewTestsFeature =
    let
        src =
            String.trim """
pub fun eval = expr =>
    when String.split ' ' expr
        is [ x, '+', y ] => x + y
        is [ x, '-', y ] => x - y
        is [ x, '*', y ] => x * y
        is [ x, '/', y ] => x / y
        is [ x, '%', y ] => x % y
    where {
        fun isEven = n => n % 2 == 0

        assert eval '1 + 2' is 3 because 1 + 2
        assert eval '2 / 3' is-roughly 0.6
        assert eval '4 % 2' satisfies isEven
        assert eval 'zero' throws !UnhandledPatternException
    }
"""
    in
    UI.Elements.Feature.codeFeature ( Right, "ren", src )
        []
        [ Html.h2
            [ Html.Attributes.class "text-gray-50 text-4xl"
            , Html.Attributes.class "mb-4"
            ]
            [ UI.Text.emphasis ( "ren-blue-400", "ren-blue-200" )
                "First-class tests"
            , Html.text "."
            ]
        , Html.p
            [ Html.Attributes.class "text-white text-lg" ]
            [ Html.text <|
                "Testing constructs for floating-point tolerance, predicate "
                    ++ "satisfication, and exception handling are built into Ren. "
                    ++ "Co-locate definitions and tests, and automatically run them "
                    ++ "during compilation."
            ]
        ]

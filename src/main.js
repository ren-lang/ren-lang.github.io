import { Elm } from './elm/Main.elm'
import { CodeFlask } from './web-components/codeflask.js'

window.customElements.define('code-flask', CodeFlask)

Elm.Main.init({
    flags: {

    }
})
import Codeflask from 'codeflask'

export class CodeFlask extends HTMLElement {
    constructor() {
        super()
        this.attachShadow({ mode: 'open' })
        this.shadowRoot.innerHTML += `
            <style> 
                :host { 
                    display: block; 
                    position: relative;
                    overflow-x: auto; 
                    width: 100%;
                    height: 100%;
                }

                * {
                    font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace !important;
                }
            </style>`
    }

    connectedCallback() {
        this.id = this.getAttribute('id') || 'code-flask'

        this.container = document.createElement('div')
        this.container.style.width = '100%'
        this.container.style.height = '100%'
        this.container.style.position = 'absolute'

        this.shadowRoot.appendChild(this.container)

        this.editor = new Codeflask(this.container, {
            language: this.getAttribute('language'),
            rtl: false,
            tabSize: 4,
            enableAutocorrect: false,
            lineNumbers: this.hasAttribute('line-numbers'),
            defaultTheme: true,
            readonly: this.hasAttribute('readonly'),
            styleParent: this.shadowRoot
        })

        this.editor.addLanguage('ren', renLanguageDefinition)

        if (this.hasAttribute('value')) {
            this.editor.updateCode(
                this.getAttribute('value')
            )
        } else {
            this.setAttribute('value', '')
        }

        this.editor.onUpdate(code => {
            if (this.getAttribute('value') !== code) {
                this.setAttribute('value', code)
                this.dispatchEvent(new Event('input'))
            }
        })
    }

    get value() {
        return this.getAttribute('value')
    }

    set value(code) {
        this.setAttribute('value', code)
        if (this.editor && this.editor.getCode() !== code) {
            this.editor.updateCode(code)
        }
    }

}

const renKeywords = ['import', 'assert', 'exposing', 'pub', 'let', 'fun', 'enum',
    'ret', 'as', 'is-roughly', 'because', 'if', 'then', 'else', 'when', 'is',
    'where', 'satisfies', 'throws'
]

const renLanguageDefinition = {
    'comment': [
        {
            pattern: /\/\/.*/,
            lookbehind: true,
            greedy: true
        }
    ],
    'string': {
        pattern: /(["'])(?:\\(?:\r\n|[\s\S])|(?!\1)[^\\\r\n])*\1/,
        greedy: true
    },
    'template-string': {
        pattern: /`(?:\\[\s\S]|\$\{(?:[^{}]|\{(?:[^{}]|\{[^}]*\})*\})+\}|(?!\$\{)[^\\`])*`/,
        greedy: true,
        inside: {
            'template-punctuation': {
                pattern: /^`|`$/,
                alias: 'string'
            },
            'interpolation': {
                pattern: /((?:^|[^\\])(?:\\{2})*)\$\{(?:[^{}]|\{(?:[^{}]|\{[^}]*\})*\})+\}/,
                lookbehind: true,
                inside: {
                    'interpolation-punctuation': {
                        pattern: /^\$\{|\}$/,
                        alias: 'punctuation'
                    },
                    rest: Prism.languages.ren
                }
            },
            'string': /[\s\S]+/
        }
    },
    'keyword': new RegExp(renKeywords.join('|')),
    'boolean': /\b(?: true | false) \b /,
    'function': null,
    'number': /\b0x[\da-f]+\b|(?:\b\d+(?:\.\d*)?|\B\.\d+)(?:e[+-]?\d+)?/i,
    'operator': /=|\||=>|\|>|>>|\+|-|\*|\/|%|\^|==|!=|>|>=|<|<=|&&|\|\||\+\+|::/,
    'punctuation': /[{}[\];(),.:]/
}

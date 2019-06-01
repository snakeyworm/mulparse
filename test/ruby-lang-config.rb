[ 
    {
        name: "module",
        start: %r{module#{SNOLB}+(?:[\\]#{SNOLB}*\r\n\f#{SNOLB}*)?(?<name>[A-Z]\w*)},
        #start: %r{[[:blank:]]module[[:blank:]]+},
        finish: %r{\send\s},
    },
    {
        name: "class",
        start: %r{
                \sclass[^\S\n]+(?:[\\]\s*)?[A-Z]\w*[^\S\n]+(?:[\\]\s*)?(?:<[^\S\n]+(?:[\\]\s*)?[A-Z][\w]*)?},
        finish: %r{\send\s},
    },
    {
        name: "singleton-class",
        start: %r{\sclass[\s/]+<<[^\S\n]+\w*},
        finish: %r{\send\s},
    },
    {
        name: "method",
        start: /(?<modifier>(?:private)|(?:public)|(?:protected))?\s+def[\t ]+[\w\.]+\(.*\)/,
        finish: /\s+end\s/,
    },
    {
        name: "case",
        start: /\s+case[\s\(]/,
        finish: /\s+end\s/,
    },
    {
        name: "if",
        start: /^[\t ]*if[\s\(]/ ,
        finish: /\s+end\s/,
    },
    {
        name: "if-modifier",
        start: /[^;\n]+[\t ]+if[\s\(]/,
        finish: /\n/,
    },
    {
        name: "unless",
        start: /^[\t ]*unless[\s\(]/,
        finish: /\s+end\s/,
    },
    {
        name: "block",
        start: /(?:\s+for[\t ]+.+[\t ]+in[\t ]+.+[\t ]+do\s)|(?:\s+\w+[\t ]*[(]?.*[)]?[\t ]+do\s)/,
        finish: /\s+end\s/

    },
    {
        name: "begin",
        start: /\s+begin[\s\(]/m,
        finish: /\s+end\s/,  
    },
    {
        name: "block or hash",
        start: /{(?<content>.*?)}/m,
    },
    {
        name: "double-quoted-string",
        start: %r{"(?<content>.*?(?<escape>[\\]*))"},
    },
    {
        name: "single-quoted-string",
        start: %r{'?(<content>.*?(?<escape>[\\]*))'},
    },
    {
        name: "here-document",
        start: /[\D\w]\w*\s+(?:<<["'~\-]*(\w+)["'~\-]?,[^\S\n\f])*(?:<<["'~\-]*(?<EOD>\w+)["'~\-]?)/,
        finish: "(?<escape>[\\\\]*)%{EOD}",
        unestable: true,
    },
    {
        name: "Regular Expression",
        start: %r{/(?<content>.*?(?<escape>[\\]*))/},
    },
    {
    name: "single-line-comment",
    start: %r{#(?<content>.*)$},
    },
    {
    name: "block-comment",
    start: %r{^=begin(?<content>.*)^=end}m,
    },
]
def generateTaggedRawString(name, tag_pattern, inner_pattern, tag_as_meta:false)
    # tag as meta is used when the contents of the raw string probably shouldn't be colored as a string
    # (because they're part of another language or syntax)
    meta = ""
    meta = "meta." if tag_as_meta
    return PatternRange.new(
        start_pattern: Pattern.new(
            match: Pattern.new(
                match: maybe(/[uUL]8?/).then(/R/),
                tag_as: "meta.encoding"
            ).then(/\"/).then(tag_pattern).then(/\(/),
            tag_as: "punctuation.definition.string.begin"
        ),
        end_pattern: Pattern.new(
            match: Pattern.new(")").then(tag_pattern).then(/\"/),
            tag_as: "punctuation.definition.string.end"
        ),
        tag_as: meta+"string.quoted.double.raw.#{name}",
        includes: [
            inner_pattern,
        ]
    )
end

def getRawStringPatterns()
    # this does not use the new syntax as its requires a feature not yet supported
    default = LegacyPattern.new(
        begin: "((?:u|u8|U|L)?R)\"(?:([^ ()\\\\\\t]{0,16})|([^ ()\\\\\\t]*))\\(",
        beginCaptures: {
            "0" => {
                name: "punctuation.definition.string.begin"
            },
            "1" => {
                name: "meta.encoding"
            },
            "3" => {
                name: "invalid.illegal.delimiter-too-long"
            }
        },
        end: "\\)\\2(\\3)\"",
        endCaptures: {
            "0" => {
                name: "punctuation.definition.string.end"
            },
            "1" => {
                name: "invalid.illegal.delimiter-too-long"
            }
        },
        name: "string.quoted.double.raw"
    )
    regex = generateTaggedRawString("regex", Pattern.new(/_r/).or(/re/).or(/regex/), "source.regexp.python")
    sql = generateTaggedRawString("sql", Pattern.new(/[pP]?(?:sql|SQL)/).or(/d[dm]l/), "source.sql", tag_as_meta: true)
    glsl = generateTaggedRawString("glsl", Pattern.new(/glsl/).or(/GLSL/), "source.glsl", tag_as_meta: true)
    return [
        regex,
        glsl,
        sql,
        default,
    ]
end

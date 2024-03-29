# frozen_string_literal: true
require 'ruby_grammar_builder'

export = Grammar.new_exportable_grammar
export.external_repos = [:inline_comment]
export.exports = [:std_space]

export[:std_space] = Pattern.new(
    # NOTE: this pattern can match 0-spaces so long as its still a word boundary
    # this is the intention since things like `int/*comment*/a = 10` are valid in c++
    # this space pattern will match inline /**/ comments that do not contain newlines
    # >0 length match
    match: oneOf([
        Pattern.new(
            at_least: 1.times,
            quantity_preference: :as_few_as_possible,
            match: Pattern.new(
                match: @spaces,
                dont_back_track?: true,
            ).or(export[:inline_comment])
        ),
        /\b/,
        lookAheadFor(/\W/),
        lookBehindFor(/\W/),
        @start_of_document,
        @end_of_document,
    ]),
    includes: [
        :inline_comment,
    ],
)
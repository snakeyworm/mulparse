
snakeyworm John 3:16

# Mulparse
***

 Mulparse is a multilingual-parser for coding languages. The philosophy
 behind this parser is having the ability to focus on bigger aspects of
 your project. Parsing is a small and tedious aspect. This parser has the
 advantage of being able to parse anything if properly defined in a "lang-config"
 This parser also has many predefined "lang-configs" that provide simple
 and efficient parsing of the languages you love. This parser was designed
 to be easier to learn than a parser like citrus. The citrus parser has its
 own mini language to learn. Mulparse only has simple hashes with a few fields
 that contain simple values.

### Lang-config Syntax
***

 A lang-config is simply an array that contains hashes where each hash defines
 how to parse a component. A hash can contain the following fields where each
 field is a symbol&#58;

+ name (Required)
+ start (Required)
+ finish (Required)
+ unestable
+ hash

#### name

 This field is a string that represents the name of the component matched

#### start

 A regular expression the matchesthe opening delimiter of a component. 

#### finish

 Either a regular expression or a string. If it is a regular expression it simply
 matches the end delimiter of a component. One should note the special treatment of
 any capture named "escape" in this regular expression. Where the regular expression
 doesn't match unless the named capture's length is even. This is useful for matching
 things such as strings that have an escape character. Otherwise if it is a string then
 any named capture. If it is a string than all named captures from the start regular
 expressions are passed to Regexp.escape() then the return value of Regexp.escape are
 formatted into the string then it is converted to a regular expression. Note when this
 field is a string "escape" is still specially treated.

#### unestable

 Is a boolean value denoting wether or not the component it is applied on can't nest any
 other components.

#### hash

 This field is a hash. This hash's keys are used when the finish field is a string. In this
 case all named captures from start are passed to this hash to retrieve a value to be formatted
 into finish before it is converted to a regular expression.

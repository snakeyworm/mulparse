
# snakeyworm John 3:16

# This file defines a class that contains
# data collected by the parser(Commonly referred
# to as components). Each instance of this class
# is linked to a parent and one or more child nodes.

# TODO:
#   
#   * Expand as needed to fit expanding lang config and
#    parser.
#

class Component

    # Class that wraps component data and provides hierarhcy navigation

    # Declare accessor's to metadata

    # Delimiters

    attr_accessor :start_match
    attr_accessor :finish_match

    # Hierarchial

    attr_reader :parent
    attr_reader :children

    # Lang config
    
    attr_reader :name
    
    attr_reader :start
    attr_reader :finish

    attr_reader :unestable

    attr_reader :hash

    def initialize(
        next_start=nil,
        parent=nil,
        name: nil,
        start: nil,
        finish: nil,
        unestable: nil,
        hash: nil )

        #   Initialize the ComponentNode with the
        #   data provided.

        @start_match = next_start # Store the component's opening match

        # Set up lang config attributes

        @name = name
        
        @start = start
        @finish = finish
        
        @unestable = unestable

        @hash = hash

        @parent = parent # Set the ComponentNode's parent
        @parent.children << self if parent

        @children = []; # Set the children of this ComponentNode to an empty array

    end

    def sibling( offset=1 )

        # Returns the sibling offset by the
        # provided parameter.

        return @parent.children[ @parent.children.index( self ) + offset ]

    end

    def has_sibling_at?( offset=1 )
        
        # Returns true if a call to sibling() with the
        # same parameter would run without error.

        return @parent.children.index( self ) + offset < @parent.children.length

    end

    def get_src( src )

        # Return the matches and the content between
        # them in the src provided.

        begin
            return src[ ( @start_match.begin( 0 )...@finish_match.end( 0 ) ) ]
        rescue NoMethodError
            return @start_match[0]
        end

    end

    def to_s()

        # Return a string representation of this Component

        if @start_match then

            abbreviated_start_match = @start_match[0][0..10]
            abbreviated_start_match += "..." if @start_match.length > 11

        end

        return "Component(\n" \
            "    start_match=%p,\n" \
            "    parent.name=%p,\n" \
            "    name=%p,\n" \
            "    start=%s,\n" \
            "    finish=%s,\n" \
            "    unestable=%p\n" \
            ")" % [
                abbreviated_start_match,
                @parent&.name,
                @name,
                @start,
                @finish || "nil",
                @unestable
            ]

    end

end

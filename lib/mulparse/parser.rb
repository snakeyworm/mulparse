
# snakeyworm John 3:16

# This files defines the class that actually
# performs IO on the file(s) provided and
# parses the input.

require "YAML"

class Parser

    # This class is used to instantiate an instance that provides
    # Enumerable interface for parsing.
    #
    # TODO:
    #
    #   * Ensure that the lang config ussage is well documented.
    #

    include Enumerable

    attr_reader :src

    def initialize( src, lang_config )

        # Initialize a parser and set lang_config and other parsing configurations

        @src = src # src must be loaded from a text stream not a binary one

        if lang_config.class == String then
            
            # Open predefined lang-config
            
            @lang_config = YAML.load( IO.read(
                "#{File.absolute_path( File.expand_path( File.join( File.dirname( __FILE__ ), '..' ) ) )}" \
                "/mulparse/lang-configs/#{lang_config}.yaml" 
            ) )

        else
            # Else use user provided lang-config
            @lang_config = lang_config
        end

        @position = 0

        # Store the current Component
        @current = Component.new( finish: true )

    end

    def each( &block )

        # Implements each method defined in Enumerable.
        # This method passes the next component parsed
        # in the srouce. The component is in the form
        # of a Component.

        loop do
        
            # Either finish the currentCN or open a new one on each iteration

            # Get the next start delimiter and its corresponding lcEntry

            next_start, start_entry = get_next_start()

            # Keep track of the existance of the finish attribute
            has_finish = @current.finish && @current.finish != true # A true value indicates the root Component

            if has_finish then

                # If finsih regex provided prepare closing regex

                closing_regex = @current.finish

                if closing_regex.is_a?( String ) then
                    
                    # Format in mirror to the closing_regex if mirror is provided

                    if @current.hash then

                        # Process hash argument if provided

                        closing_regex = Regexp.new( closing_regex % Hash.new { |_, key|
                            Regexp.escape( @current.hash[ @current.start_match[ key ] ] || @current.start_match[ key ] )
                        } )

                    else

                        # Else process normally

                        closing_regex = Regexp.new( closing_regex % Hash.new { |_, key|
                            Regexp.escape( @current.start_match[ key ] )
                        } )

                    end

                end

                # Match for next closing delimiter
                next_finish = closing_regex.match( @src, @position )
                
                raise UnmatchedException.new(
                    @current.name,
                    @src[ 0..@current.start_match.end( 0 ) ].count( "\n" ) + 1
                ) unless next_finish

                # Ensure "escape" capture is valid

                until next_finish[ :escape ].length.even?

                    # Match until length of "escape" capture is even
                    next_finish = closing_regex.match( @src, next_finish.end( 0 ) )
                
                end if closing_regex.names.include?( "escape" )

            end

            if !next_start then
                
                # If done parsing yield last Component

                @current.finish_match = next_finish
                yield @current

                break

            end

            break if !next_start # Break if pasrsing is complete

            if @current&.parent && ( has_finish &&
                ( @current.unestable || next_finish.begin( 0 ) < next_start.begin( 0 ) ) ) then
            
                # If current Component should be finished then finish it

                begin
                    @position = next_finish.end( 0 ) # Update position
                rescue NoMethodError
                    
                    # Raise UnmatchedException if next_finish is nil

                    raise UnmatchedException.new(
                        @current.name,
                        @src[ 0..@current.start_match.end( 0 ) ].count( "\n" ) + 1
                    )
                    
                end

                # Update parsing data
                @current.finish_match = next_finish

                # Yield finished Component
                yield @current

                # Set current Component to the previous's parent
                @current = @current.parent

            else

                # Else new Component is found set it as current

                @current = Component.new( next_start, @current, start_entry )
                @position = next_start.end( 0 ) # Update position

                # Yield if Component uses syntactic sugar unestability
                
                unless @current.finish && @current.finish != true  then
                    yield @current
                    @current = @current.parent
                end

            end

        end

    end

    # External/Internal Utility Methods

    def line

        # Return number of lines already parsed
        return @src[ 0..@position ].count( "\n" )

    end

    # Internal Utility Methods

    protected
    
    def get_next_start

        #   This method finds the nearest match of a
        #   components starting delimiter in the @src.
        #   Returns nil if there are no more matches.

        next_start = nil # Store the next starting delimiter
        lcEntry = nil # Store the lang config entry of next_start

        for i in @lang_config do
            
            # Test match against closest starting delimiter on each iteration

            matchBuffer = i[ :start ].match( @src, @position ) # Get a match

            next unless matchBuffer # If no match is found then skip to next iteration

            # Set the value of next_start to the closer match

            next_start = ( !next_start ||
                          matchBuffer.begin( 0 ) < next_start.begin( 0 ) ) ?
                          matchBuffer : next_start

            if next_start == matchBuffer then lcEntry = i end # Update lcEntry if necessary

        end

        return next_start, lcEntry # Return the closest match

    end

end

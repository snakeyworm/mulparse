
# snakeyworm John 3:16

# This exception is raised when a Component's
# ending delimiter can't be found.
#

class UnmatchedException < MulparseException

    def initialize( name, line )

        # Initialize Exception with message
        super( "UnmatchedException: finish_match for %p at line: #{line} not found" % name )

    end

end

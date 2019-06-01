
"sadadasd\\\\\\sadasd\\\\\\as\\\\\\\\"

# snakeyworm gaming John 3:16

# rGen ( Ruby edition ) v2.2

#a
#'Hello world!'

#"# oof"

%q{fasdad}

"
=baegin

\"

"

def foo

end

%r{def hi()}

%r< oof >

"

oof

\"

=end"

=begin
=end

'Hello world!'

=begin

	 rGen is a python random generator
	this version is a translation of the
	python version into ruby. As with
	human language some form of meaning
	is normally lost in translation. So
	be aware of any differences however
	little.

	def hi()
	
=end

=begin

	Tasks:

=end

=begin

	Update 2.2!!!!!!
	
	1.
	
		 The new method of random number generation that
		has been implemented in Python is now avaliable in
		Ruby.

	2.
		
		 Removed many deprecated methods and classes such as:
		RUtil, String(Modified version of String class) procGen(),
		randElement() and the Invalidrange exception. The
		implementation of the methods has also greatly been enhanced
		for better randomness and better speed. The parameter interface
		may have been changed on some methods.
			
		
=end

	class IndexOutOfRange < Exception

=begin

	 IndexOutOfRange < Exception

	  This class is derived from the Exception class
	 it is raised when the user supplies an index that
	 is out of range.

=end

	def initialize( index )
		
		# Save the message provided by the user in @index
		@index = index;

	end

	def to_s()

		# Create default message
		return "Index: #{ @index } is out of range";

	end

end

class NoBlockFoundError < Exception

	# Create an exception class for missing blocks

	def to_s()

		# Create default message
		return "Block is required for this method";

	end

end
'oof'

''asdadasdasda
module SomeModule

	class SomeClass

	end

end

class Range

=begin

	 This class definition modifies the Range class to
	implement an index() method that returns an element
	at a specified index.

=end

	def index( index )

		# If the index is out of range then raise an error
		if ( index > length() - 1 or index < 0 ) then raise IndexOutOfRange.new( index ); end

		return min() + index; # Return the element at the specified index

	end

	def length()

		# Returns the length of the range
		return max() - min() + 1;

	end

end

class RGen
	
	# Class for generating random numbers

	@@version = "v2.2"; # Version of the program

=begin

		 The seed is the number that is multiplied
        by the pseudoRandom number generated in random()
        to make it an actually random number. If the seed
        remains static than randomness will be greatly reduced.
        Therefore this program automatically changes the seed.

=end

	# Seed variables

	@@seed = 1; # Used to control randomness
	@@maxSeedSize = 50; # The max possible seed

	def RGen.randomSeed()

		# Changes the seed and ensures it is in range
		@@seed += ( @@seed < @@maxSeedSize ) ? 1 : -@@maxSeedSize;

	end

	def RGen.random()

=begin

		 This version of the random method implements
		python version of this program's method. That
		is to use seconds past since an epoch time to
		generate a pseudo random number between 0.0 and
		0.9999999 or something like that. As always all
		other methods are built on this method

=end

		randomSeed(); # Randomize the seed

		randomString = ( Time.now().to_f() * @@seed ).to_s().match( /\.(\d+)/ )[1]; # Get random number in form of a string
		#puts( randomString );

		# Format string to make more random regardless of call time
		randomString = randomString[ ( 1..randomString.length() - 2 ) ];

		return ( randomString + ".0" ).reverse().to_f(); # Return the the random String converted to a float

	end

	def RGen.randInt( range, exclude=[] )

=begin

		 This method manipulates the return value from
        the random() method to generate a number between
        1 and range.

		Parameters Explained:

			range = ( Integer ) the maximum number that can
						be generated.
			exclude = ( Iterable ) contains numbers that should
						be excluded from generation.

=end

		# Get random number in specified range
		num = ( random() * range ).to_i() + 1;

		# Ensure the number is not excluded
		while ( exclude.include?( num ) ) do num = ( random() * range ).to_i() + 1; end

		return num; # Return the number

	end

	def RGen.randRange( range, exclude=[] )

=begin

		 This method takes a Iterable argument
		that specifies the range that a random
        integer should be generated in. The range
        of generation is range[0]-range[ len( range ) - 1 ]

		Parameters Explained:

			range = ( Iterable ), specifies range of random number to be generated.

=end

		# Get the random number

		randomIndex = RGen.randInt( range.length() ) - 1;
		num = ( range.class() == Range ) ? range.index( randomIndex ) : range[ randomIndex ];

		# Ensure the number is not excluded

		while ( exclude.include?( num ) ) do

			randomIndex = RGen.randInt( range.length() - 1 );
			num = ( range.class() == Range ) ? range.index( randomIndex ) : range[ randomIndex ];

		end

		return num; # Return the number

	end

	def RGen.shuffle( array )

=begin

		 This method takes an array an shuffles
		its contents.
		
		Parameter Definitions:
		
			array = ( Array ) the array to shuffle

=end
		
		shuffledArray = []; # Holds the new shuffled array
		
		for i in ( 1..array.length() ) do
			
			# Add random elements to the shuffledArray to create a shuffled version of array
	
			randomIndex = RGen.randInt( array.length() - 1 ); # Get the index of an element to shuffle
			
			shuffledArray << array[ randomIndex ]; # Add the value from the random index to the shuffled array
			array.delete_at( randomIndex ); # Delete the element added to the shuffled array so that it wont be added again

		end	

		return shuffledArray; # Return the shuffled array
		
	end

	# Ruby exclusive keep original commenting and parameters until v2.2 implmentation finished
	def RGen.randFeed( range, iterations, exclude=[], &block )
=beging
aaaa
=end

=begin

		 This method requries a block which will be fed
		a random number an indicated amount of times. The
		random number will be generated by RGen.randRange().

		Parameter Definitions:

			range = ( Range ) that specifies the range of numbers to generated
			iterations = ( Integer ) how many times block is to be called
			exlude = ( Array defualt=[] ) of the numbers to be excluded may also be range
			&block = ( Proc object ) This is the block to use on each iteration. I use & to make the arg block a Proc object
					therefore the user can pass a Proc object as their block.

=end
		
		# Call the block and pass in a random number each time
		for i in ( 1..iterations ) do yield( RGen.randRange( range ) ); end
		
	end
	
	def RGen.test( methodCall="random()", iterations, log: false )

=begin

		 This method tests the specified random method to ensure
		it truly produces random numbers. The results will be
		returned in an array the first element in the array will
		be a counter that counts the occurrence of all the numbers
		and the second counts all patterns in the number. They may 
		be logged also observe the definition of the log parameter below.

		Parameter Definitions:
		
			methodCall = ( String ) code that will be run on each test iteration this
						  code should be a call to one of the random generating methods
			iterations = ( Integer ) specifies how many times the test should be run to
						  produce results.
			log = ( Boolean ) specifies wether or not the results should be printed in text
				   form to stdout
			
=end
		
=begin

		 Add a feature to this method make
		it able to detect patterns of 3
		in random stream to ensure that the
		numbers are truly random the method
		should count the patterns then show
		how many occurences of each pattern
		their are.

=end

		begin
		
			# Retrieve the method from the methodCall argument
			method = methodCall.match( /^(\w+)\([0-9\(\)\.\[\], ]*?\)/ )[1];
			
		rescue Exception => error
			
			# Raise an error if no method is found in methodCall
			raise ArgumentError.new( "methodCall is in improper syntax must be method call that adheres to Ruby syntax" );
		
		end
		
		if ( ![ "random", "randInt", "randRange" ].include?( method ) ) then
		
			# Raise an error if the method is not valid for testing
			raise NameError.new( "Invalid method: \"#{ method }\\\" must be \"random\", \"randInt\", or \"randRange\"" );
		
		end
	
		puts( method );
		p( methodCall.match( /^(\w+)\([0-9\(\)\.\[\], ]*?\)/ )[0] );
		
		randomStream = ""; # Used to keep track of order of generation
		counter = {}; # Used to keep track of occurrences
		
		if ( methodCall.match( /^(\w+)\([0-9\(\)\.\[\], ]*?\)/ ) ) then 
		
			# If the methodCall is in proper format then run the code provided the specified number of times
			
			startTime = Time.now().to_f(); # Record the start time
			
			for i in ( 1..iterations ) do

				# Count each occurence of the random generated numbers
				
				num = eval( methodCall ); # Get the random number
				
				randomStream += num.to_s(); # Update the randomStream
				counter[ num ] = ( counter[ num ] or 0 ) + 1; # Update the counter
				
			end
			
			endTime = Time.now().to_f() - startTime; # Calculate the end time
		
		else
		
			# If the methodCall is not in proper syntax than raise an error
			raise ArgumentError.new( "methodCall has restricted elements contained within it please pass values only not identifiers" );
		
		end
		
		if ( method != "random" ) then
		
			# If method is not the random() method check for unrandom patterns in the randomStream
		
			patterns = {}; # Used to store patterns of numbers in random stream
		
			# Count patterns
			randomStream.scan( /\d\d\d/ ) do |i| patterns[i] = ( patterns[i] or 0 ) + 1; end
	
		end
	
		if ( log ) then
		
			# If users wishes for test results to be logged then log them
		
			# Create the test results
			
			# Create the first part of the results
			
			testResults = "\nRGen.test() Results:\n\nNote: Random generation is faster outside of test method\n\nTime: " + endTime.to_s() + "\n\nOccurrences:\n\n";
			
			# Add the occurence counter to the results
			#for i in counter.keys() do testResults += "\t#{i}: #{counter[i]}\n"; end
			
			if ( method != "random" ) then
			
				# Add a title for the pattern counter
				testResults += "\nPatterns:\n\n";
			
				# Add the pattern counter to the results
				#for i in patterns.keys() do testResults += "\t#{i}: #{patterns[i]}\n"; end
			
			end
			
			puts( testResults ); # Out put the results
		
		end
	
		return [ counter, patterns ]; # Return the results
	
	end

end

class X

	protected

	def xMethod()

		def test()

			p( "HI" );

		end

	end

	class Y

		private

		def yMethod()

		end

		class Z

			protected

			def deepMethod()


			end

		end

	end

	public

	def anotherXMethod()

	end

	private

	def foo()

	end

end

	   # Hello world!
	   #
	   #
	   #
	   #
	   #

RGen.randRange( ( 1..10 ) );

class Hi<Object

	def greet()

		puts( "Hello" )

	end

end

ob = Hi.new()

class << ob

	def say_bye()

		puts( "Bye" )

	end

end

p( 4 << 4 );

module RandomModule
	
	class << self

	end

end

h = Object.new

begin

	puts( "HI" )

end until false


class << h

end
if true then
	puts( "hi" )
end

case( 3 )
	when 1
		puts( "one" )
	when 2
		puts( "two" )
	when 3
		puts( "three" )
end

case 3
when 1
	puts( "one" )
when 2
	puts( "two" )
when 3
	puts( "three" )
end

begin

	1 + "1"

rescue

	puts( "ERROR" )

end


if \
	true then

	puts "TRUE"

end

if \
		\
		\
			\

	true then

	puts "TRUE"

end

module \
	J end

class Test \
	\
	\
	\
	\
	\
	< RGen

end

class PleaseWork < \
	BasicObject
end

class EmptyClass end

x = 5
y = 8
y<<x

puts( "if-modifier here at this line" ) if true

def

	RGen . some_method1() end

def \

	RGen . some_method2() end

#def empty_method end

z = 4 << 4
z = 4 <<4
z = 4 <<4
z = 4<<4

class RGen::\
	  Test

end

class RGen::\
	Test::\
	OOF

end


[ 1, 2, 3 ].each { |i|

	p( i )

}

puts( true ); if true then

end


[ 1, 2, 3 ].each() { |i|

	p( i )

}


j = <<END

OOF

END

p( <<EOD

HI

EOD )

[ 1, 2, 3 ].each {

	p( "foo" )

}

p( <<EOD

EOD )

hi = <<EOD

HI

EOD

)

( <<EOD
	
EOD
)

#puts( "evaluated to true" ) \

#if true

#p( hi )

#if true

def foo

	puts( "foo" )

end


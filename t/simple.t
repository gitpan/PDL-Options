#!/usr/local/bin/perl


BEGIN { $| = 1; print "1..3\n"; }
END {print "not ok 1\n" unless $loaded;}
use PDL::Options;
$loaded = 1;
print "ok 1\n";

# A test script for the PDL::Options package.
# simply setup a PDL::Options object and check that the
# options are set correctly

# Create new object and supply defaults
$opt = new PDL::Options(   { Colour => 'red',
			     LineStyle => 'dashed',
			     LineWidth => 1
			   }
		       );

# Create synonyms
$opt->synonyms( { Color => 'Colour' } );

# Create translation dictionary
$opt->translation( { Colour => {
				'blue' => '#0000ff',
				'red'  => '#ff0000',
				'green'=> '#00ff00'
			       },
		     LineStyle => {
				   'solid' => 1,
				   'dashed' => 2,
				   'dotted' => 3
				  }
		   }
		 );

# Make sure that only the modified members are returned
$opt->full_options(0);

# Generate and parse test hash
$options = $opt->options( { Color => 'green',
			    lines => 'solid',
			  }
			);


# Check the options
# The options should now have LineStyle 1 and Colour #00ff00
# Even though the input was lines => 'solid' and Color=>'green'

if ($options->{Colour} eq '#00ff00') {
  print "ok 2\n";
} else {
  print "not ok 2\n";
}


if ($options->{LineStyle} == 1) {
  print "ok 3\n";
} else {
  print "not ok 3\n";
}

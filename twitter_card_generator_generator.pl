use strict;
use warnings;
use utf8;
use WWW::Mechanize;
use Getopt::Long;

$| = 1;

GetOptions(
	'png'      => \my $png,
	'pdf'      => \my $pdf,
	'trim-pdf' => \my $trim_pdf,
);

my($form_number, $ext) = do {
	my ($f, $e) = (2, 'png');
	if ($pdf) {
		($f, $e) = (3, 'pdf');
	}
	elsif ($trim_pdf) {
		($f, $e) = (4, 'pdf');
	}
	($f, $e);
};

# Initialize
my $mechanize = WWW::Mechanize->new(
	autocheck => 1
);
$mechanize->agent_alias('Mac Safari');

while (<>) {
	chomp; chomp;
	my $twitter_id = $_;
	
	$mechanize->get("http://twitter.tyoe2.com/meishi/");

	# Form input time..
	sleep rand 4;

	print "$twitter_id : First Form.... ";
	$mechanize->submit_form(
		fields => +{
			twitterid   => $twitter_id,
			spout       => "bio",
			statustxt   => "",
			bgcolorcode => "#94e4e8",
			meishitmp   => "mtmp_tate1,kokubucamera",
			mtmpcol     => "",
			txtcolor    => "",
			mode        => "ok",
		},
	);

	sleep rand 2;

	print "Second Form... ";
	$mechanize->submit_form(
		form_number => $form_number,
	);

	print "Image Save... ";
	open my $card, '>', "${twitter_id}.${ext}" or die;
	print $card $mechanize->content;
	close $card;

	print "Complete!\n";

	sleep rand 2;
}


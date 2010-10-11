#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  twitter_card_generator_generator.pl
#
#        USAGE:  ./twitter_card_generator_generator.pl <Twitter ID>
#
#  DESCRIPTION:  Twitter名刺ジェネレータを一括生成
#   - ID.png を生成します
#
#       AUTHOR:  bobpp < bobpp@bobpp.jp >
#      VERSION:  1.0
#      CREATED:  10/05/2010 02:59:19
#===============================================================================

use strict;
use warnings;
use utf8;
use WWW::Mechanize;

$| = 1;

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
		form_number => 2,
	);

	print "Image Save... ";
	open my $card, '>', "${twitter_id}.png" or die;
	print $card $mechanize->content;
	close $card;

	print "Complete!\n";

	sleep rand 2;
}


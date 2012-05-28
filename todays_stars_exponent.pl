use strict;
use warnings;
use URI;
use Web::Scraper;
use utf8;
binmode(STDOUT, ':utf8');

my $scraper = scraper {
  process '//tr[1]/td/b', 'day', 'TEXT';
  process '//tr[3]/td/small/b', 'index', 'TEXT';
};

my $res = $scraper->scrape( URI->new("http://weather.yahoo.co.jp/weather/jp/expo/starry/47/9110.html") );
print $res->{day}, $res->{index}, "\n";

use strict;
use warnings;
use utf8;
use URI;
use Web::Scraper;

binmode(STDOUT, ":utf8");

sub search {
    my $keyword = shift;

    my $scraper = scraper {
        process '//*[@class="programlist"]/li', 'lists[]' => scraper {
            process '.rightarea .yjLS',               'title', => 'TEXT';
            process '.rightarea .pr35',               'ch',    => 'TEXT';
            process '.leftarea .yjMS',                'day',   => 'TEXT';
            process '//*[@class="leftarea"]/p[2]/em', 'date',  => 'TEXT';
        };
    };

    my $url = URI->new('http://tv.yahoo.co.jp/search/');
    $url->query_form(q => $keyword, a => '62');
    my $res = $scraper->scrape($url);
    for my $program (@{$res->{lists}}) {
        print $program->{day}, $program->{date}, $program->{title}, $program->{ch}, "\n";
    }
}

chomp(my $msg = <STDIN>);

if ($msg =~ m/^tv\s/) {
    $msg =~ s/^tv\s//;
    &search($msg);
}

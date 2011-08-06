use strict;
use AnyEvent;
use AnyEvent::IRC::Client;

# 接続設定
my $channel = '#hoge';
my %config = (
    server   => 'chat.freenode.net',
    port     => 0000,
    info     => {
        nick => 'botbot',
        real => 'botbot',
    }
);

# 状態変数生成
my $condvar = AnyEvent->condvar;

# IRC イベント
my $irc = AnyEvent::IRC::Client->new;
$irc->reg_cb(
    # 接続時に呼び出されるイベント
    connect => sub {
        my ($irc, $err) = @_;
        if (defined $err) {
            print "connect error: $err\n";
            return;
        }
        print "connected.\n";
    },

    # 接続成功時に呼び出されるイベント
    registered => sub {
        print "registered.\n";
    },

    # 切断時に呼び出されるイベント
    disconnect => sub {
        print "disconnected.\n";
    },
);

# IRC サーバに接続
$irc->connect($config{server}, $config{port}, $config{info});

# $channel に join
$irc->send_srv("JOIN", $channel);

# $channel に notice メッセージを送る
$irc->send_chan($channel, "NOTICE", $channel, "Hi");

# イベント待ち
$condvar->recv;

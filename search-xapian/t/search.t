# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
use Devel::Peek;
BEGIN { plan tests => 18 };
use Search::Xapian qw(:ops);

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

# None of the following tests can be expected to succeed without first
# creating a test database in the directory testdb.

my $db;
ok( $db = Search::Xapian::Database->new( 'testdb' ) );

my $enq;
ok( $enq = $db->enquire() );

my ($query1, $query2, $query3, $query4);
ok( $query1 = Search::Xapian::Query->new( 'test' ) );
ok( $query2 = Search::Xapian::Query->new( OP_OR, 'test', 'help' ) );
ok( $query3 = Search::Xapian::Query->new( OP_OR, $query1, $query2 ) );
ok( $query4 = Search::Xapian::Query->new( OP_OR, 'test', 'help', 'one', 'two', 'three' ) );
ok( $query4->get_description() );

ok( $enq = $db->enquire( $query2 ) );
ok( $enq = $db->enquire( OP_OR, 'test', 'help' ) );

my $matches;
ok( $matches = $enq->get_mset( 0, 10 ) );
ok( $matches->get_matches_estimated() );
ok( $matches->size() );

my $match;
ok( $match = $matches->begin() );
ok( $match++ );
ok( $match->get_docid() );
ok( $match->get_percent() );

my $doc;
ok( $doc = $match->get_document() );
ok( $doc->get_data() );

1;

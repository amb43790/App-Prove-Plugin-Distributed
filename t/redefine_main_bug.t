
=head1 DESCRIPTION

1)  If a test file contain a package "main", the Distributed test will fail.
For example, the code below in the test file.


    ...

    package NoForkProcess;
    use vars qw( @ISA );
    @ISA = qw( TAP::Parser::Iterator::Worker );

    sub _use_open3 { return }

    package main;

    my $listener = IO::Socket::INET->new(
	Listen => 5,
	Proto  => 'tcp'
    );

    ...

################################################################################

Thank to Anthony Brummett for fixing this bug.

The bug fix is contributed by amb43790 (Anthony Brummett) github user.

=cut

use strict;
use warnings;

use Test::More tests => 3;

use_ok('IO::Socket::INET');

ok(chdir "/tmp/", 'change directory');


package NoForkProcess;
use vars qw( @ISA );
@ISA = qw( TAP::Parser::Iterator::Worker );

sub _use_open3 { return }

package main;

my $listener = IO::Socket::INET->new(
    Listen => 5,
    Proto  => 'tcp'
);

ok($listener, 'got a listener');

done_testing();

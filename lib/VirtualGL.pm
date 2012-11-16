package VirtualGL;

use v5.16.1;
use Mouse;
use General;

extends 'General';

has 'display' => (is => 'ro', isa => 'Str', default => ':0');

sub run{
	my $self = shift;
	
	my $arg = shift;
	
	my $conf = $self->globalcfg;
	my $vglrun = "$$conf{virtualgl}/bin/vglrun";
	system "$vglrun -d " . $self->display . " $arg";
}

1;
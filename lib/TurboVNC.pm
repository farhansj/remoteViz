package TurboVNC;

use v5.16.1;
use Mouse;
use General;

extends 'General';

has 'vncdir' => (is => 'ro', isa => "Str", default => "$ENV{'HOME'}/.vnc");
has 'min_geometry' => (is => 'ro', isa => "Int", default => 100 );

sub BUILD{
	my $self = shift;
	
	$self->check_vncdir();
}

sub check_vncdir{
	my $self = shift;
	
	unless (-d $self->vncdir){
		mkdir($self->vncdir);
	}
}

sub check_passwd{
	my $self = shift;
	
	my $passwd = $self->vncdir . "/passwd";
	unless(-e "$passwd"){
		say "please set a password first, you can use 'remoteViz set password'";
		exit 255;		
	}
}

sub error_geometry{
	my $self = shift;
	
	say "Invalid geometry";
	exit 255;
}

sub check_geometry{
	my $self = shift;
	
	my $geometry = shift;
	my @tmp = split 'x' => $geometry;
	if($#tmp == 1){
		unless(($tmp[0] >= $self->min_geometry) and ($tmp[1] >= $self->min_geometry)){
			say "minimum geometry widht/height is " . $self->min_geometry;
			$self->error_geometry();
		}
	}else{
		$self->error_geometry();
	}
}

sub set_passwd{
	my $self = shift;
	
	my $conf = $self->globalcfg;
	my $cmd = "$$conf{turbovnc}/bin/vncpasswd -v";
	system "$cmd";
}

sub set_vncserver{
	my $self = shift;
	
	my ($geometry, $description) = @_;
	
	#check if vnc passwd file is exist
	$self->check_passwd();
	
	my $conf = $self->globalcfg;
	my $vncserver = "$$conf{turbovnc}/bin/vncserver";
	my $depth = $$conf{depth};
	my $prefix = $$conf{prefixname};
	
	#set unless been defined
	$geometry = $$conf{geometry} unless defined $geometry;
	$description = 'none' unless defined $description;
	
	$self->check_geometry($geometry);
	
	say "$depth $prefix $geometry $description";
}

1;
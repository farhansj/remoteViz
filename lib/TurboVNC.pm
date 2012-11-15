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
	
	system qq#$vncserver -geometry $geometry -name "$prefix - $description" -depth $depth#;
}

sub stop_vnc{
	my $self = shift;
	
	my $id = shift;
	
	my $conf = $self->globalcfg;
	my $vncserver = "$$conf{turbovnc}/bin/vncserver";
	my $cmd = `$vncserver -kill :$id`;

}

sub list_vnc{
	my $self = shift;
	
	my $cmd = `ps x -o command | grep 'desktop Novaglobal' | grep -v grep`;
	print "no visualization detected\n" and exit 1 unless $cmd;
	my @vnc = split '\n' => $cmd;
	
	$self->print_header();
	
	for(@vnc){
        print $self->get_session($_) . "\n";
	}
}

sub get_session{
	my $self = shift;
    my $line = shift;

    my ($id, $desc, $port, $geometry, $session);
    if($line =~ /.*Novaglobal - (.*)-httpd.*-geometry (.*)-depth.*-rfbport (\d+)?/){
            $desc = $1;
            $geometry = $2;
            $port = $3;
            $id = $port - 5900;
    }
    $session = "$id\t$port\t$geometry\t$desc";
    return $session;
}


sub print_header{
	my $self = shift;
	
    print "ID\tPort\tGeometry\tDescription\n";
    print "=" x 50;
    print "\n";
}

1;
package General;
use v5.16.1;
use Mouse;

has 'globalcfg' => (is => "rw" , builder => 'getGlobalConfig');

sub BUILD{
	my $self = shift;
	
	my $conf = $self->globalcfg;
	$self->check_vnc($$conf{turbovnc});
	$self->check_virtualgl($$conf{virtualgl});
}

sub check_vnc{
	my $self = shift;
	
	my $path = shift;
	
	unless(-e "$path/bin/vncserver"){
		say "Error : vncserver not found";
		exit 255;
	}
}

sub check_virtualgl{
	my $self = shift;
	
	my $path = shift;
	
	unless(-e "$path/bin/vglrun"){
		say "Error : virtualgl not found";
		exit 255;
	}
}

sub getGlobalConfig{
	my $self = shift;
	
	my $configfile = "$ENV{'remoteViz_ROOT'}/etc/global.conf";

	my $conf = new Config::General(
				-ConfigFile => $configfile
			);

	my %config = $conf->getall();
	return \%config;
}

1;

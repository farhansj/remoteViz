package RemoteViz::Command::Stop;

use base qw( CLI::Framework::Command );
use v5.16.1;

#return usage output
sub usage_text{
    my $usage = <<EOF;
Usage:
remoteViz stop [id]

EOF
}

sub validate{
    my ($self, $cmd_opts, @args) = @_;
    
    if(defined $cmd_opts->{'help'}){
        die $self->usage_text();
    }
    die $self->usage_text() unless defined $args[0];
    die $self->usage_text() unless $args[0] =~ /\b\d+\b/;
}

sub option_spec {
    # The option_spec() hook in the Command Class provides the option
    # specification for a particular command.
    [ 'help|h' => 'help' ],
}


sub run{
	my ($self, $opts, @args) = @_;
   
   use TurboVNC;
   my $obj = TurboVNC->new();
   
	$obj->stop_vnc($args[0]);
   
   return;
}

1;
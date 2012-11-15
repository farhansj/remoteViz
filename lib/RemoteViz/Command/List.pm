package RemoteViz::Command::List;

use base qw( CLI::Framework::Command );
use v5.16.1;

#return usage output
sub usage_text{
    my $usage = <<EOF;
Usage:
remoteViz list

EOF
}

sub validate{
    my ($self, $cmd_opts, @args) = @_;
    
    if(defined $cmd_opts->{'help'}){
        die $self->usage_text();
    }
    
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
   
	$obj->list_vnc();
   
   return;
}

1;
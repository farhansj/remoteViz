package RemoteViz::Command::Set;

use base qw( CLI::Framework::Command );
use v5.16.1;

#return usage output
sub usage_text{
    my $usage = <<EOF;
Usage:
remoteViz set [--cmd-opt] [cmd-arg]

available cmd-arg:
password      
            
example:
#set vnc password
remoteViz set password

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
   
   my $obj;
   
   
   return;
}

1;
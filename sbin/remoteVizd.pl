use Daemon::Generic;

my $sleeptime = 1;

 newdaemon(
        progname        => 'remoteVizd',
        pidfile         => '/var/run/remoteVizd.pid',
        configfile      => "$ENV{remoteViz_ROOT}/etc/global.conf",
 );

 sub gd_preconfig
 {
        my ($self) = @_;
        open(CONFIG, "<$self->{configfile}") or die;
        while(<CONFIG>) {
                $sleeptime = $1 if /^remoteVizd_interval=(\d+)/;
        }
        close(CONFIG);
        return ();
 }

 sub gd_run
 {
        while(1) {
                sleep($sleeptime);
                print scalar(localtime(time))."\n";
        }
 }
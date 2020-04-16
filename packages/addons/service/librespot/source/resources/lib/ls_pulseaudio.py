import subprocess

from ls_addon import log as log


def run(command):
    return subprocess.check_output(command.split())


class Pulseaudio:

    def __init__(self, settings):
        self.null_sink = dict(
            module='module-null-sink',
            args='sink_name={device}'.format(**settings)
        )
        self.rtp_send = dict(
            module='module-rtp-send',
            args='destination_ip={rtp_dest} port={rtp_port}'
                 ' source={device}.monitor'.format(**settings)
        )
        self.suspend = 'pactl suspend-sink {device} {{}}'.format(**settings)
        self.url = 'rtp://{rtp_dest}:{rtp_port}'.format(**settings)

    def list_modules(self):
        return [module.split('\t')
                for module in run('pactl list modules short').splitlines()[::-1]]

    def load_modules(self):
        args = [module[2] for module in self.list_modules()]
        for module in [self.null_sink, self.rtp_send]:
            if module['args'] not in args:
                run('pactl load-module {} {}'.format(
                    module['module'], module['args']))
                log('loaded {} {}'.format(module['module'], module['args']))
        self.suspend_sink(1)

    def suspend_sink(self, bit):
        run(self.suspend.format(bit))
        log('suspended sink {}'.format(bit))

    def unload_modules(self):
        for module in self.list_modules():
            if module[2] in [self.null_sink['args'], self.rtp_send['args']]:
                run('pactl unload-module {}'.format(module[0]))
                log('unloaded {} {}'.format(module[1], module[2]))

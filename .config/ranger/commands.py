from ranger.api.commands import Command
import os


class mount_zip(Command):
    """:mount_zip

    Mount the selected zip files in the current directory
    """

    def execute(self):
        for file in self.fm.thistab.get_selection():
            try:
                mount_point = os.environ['XDG_RUNTIME_DIR'] + '/ranger-mounts/' + file.path
                if os.path.isdir(mount_point):
                    os.system('fusermount -u ' + mount_point)
                else:
                    os.system('mkdir -p ' + mount_point)
                os.system('fuse-zip ' + file.path + ' ' + mount_point)
                self.fm.cd(mount_point)
            except Exception as ex:
                self.fm.notify(ex)

        try:
            # reloading directory.  maybe its better to reload the selected
            # files only.
            self.fm.thisdir.load_content()
        except:
            pass


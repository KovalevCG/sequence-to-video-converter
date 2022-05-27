# This Python file uses the following encoding: utf-8
import sys
import subprocess
import glob
import re
import os
from configparser import ConfigParser
from distutils.util import strtobool

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal


class MainWindow(QObject):

    def __init__(self):
        QObject.__init__(self)
        # Config Parser
        self.config = ConfigParser()
        self.config.read(os.path.join(os.path.dirname(sys.argv[0]), "settings.ini"))

        # Variables
        self.print_message =  'by Alexander Kovalev'
        self.stvc_path = os.path.dirname(sys.argv[0])

        self.sequence_folder = ''
        self.sequence_mask = ''
        self.output_file_name = ''


        # Paths and files
        if len(sys.argv) > 1:
            self.AssignSequenceVariables(sys.argv[1])
        else:
            #self.AssignSequenceVariables(os.path.join('Z:/personal/2001_SIM_BaloonCars/HOU/render/testTaxi02_30fps', 'testTaxi02.001.effectsResult.jpg'))
            self.print_message = 'Select one of the sequence files.'

        # Emit UI path variables


    setSequence_mask = Signal(str)
    setSequence_folder = Signal(str)
    setOutput_file_name = Signal(str)

    setOutput_file_name = Signal(str)
    setFps = Signal(int)
    setFormat = Signal(int)
    setAlpha = Signal(bool)
    setQuality = Signal(int)
    setBitrate = Signal(int)
    setRemove = Signal(bool)
    setChange_output = Signal(bool)
    setOutput_path = Signal(str)

    setPrintLog = Signal(str)

    def AssignSequenceVariables(self, path):

        # Assign path variables
        self.sequence_path = path
        self.sequence_folder = os.path.dirname(self.sequence_path)
        self.sequence_full_file_name = os.path.basename(self.sequence_path)
        self.sequence_file_name, self.sequence_extension = os.path.splitext(self.sequence_full_file_name)
        self.sequence_extension = self.sequence_extension[1:]
        self.sequence_file_name_prefix = ''
        self.sequence_file_name_digits = ''
        self.sequence_file_name_suffix = ''

        self.sequence_files = []
        self.sequence_numbers = []

        # check if extension is correct
        if ((self.sequence_extension.lower() != 'jpg') and (self.sequence_extension.lower() != 'png') and (self.sequence_extension.lower() != 'jpeg') and (self.sequence_extension.lower() != 'tif') and (self.sequence_extension.lower() != 'tiff')):
            self.print_message =  'Wrong file format. Extension should be .jpg .jpeg .png .tif or .tiff'
            self.sequence_folder = ''
            self.sequence_mask = ''
            self.output_file_name = ''
            return
        else:
            self.print_message =  'Sequence loaded'

        print("self.sequence_path", self.sequence_path)
        print("self.sequence_folder", self.sequence_folder)
        print("self.sequence_full_file_name", self.sequence_full_file_name)
        print("self.sequence_file_name", self.sequence_file_name)
        print("self.sequence_extension", self.sequence_extension)

        # number of digits at the end of filename (or in the middle)
        self.sequence_file_name_reverse = self.sequence_file_name[::-1]
        for self.i in self.sequence_file_name_reverse:
            if self.i.isdigit():
                self.sequence_file_name_digits += self.i
            else:
                if self.sequence_file_name_digits == '':
                    self.sequence_file_name_suffix += self.i
                    continue
                else:
                    break

        # check if digits exist in filename
        if self.sequence_file_name_digits == '':
            self.print_message =  'Error: No digits in filename.'
            self.sequence_folder = ''
            self.sequence_mask = ''
            self.output_file_name = ''
            return

        self.sequence_file_name_digits = self.sequence_file_name_digits[::-1]
        self.sequence_file_name_suffix = self.sequence_file_name_suffix[::-1]
        self.sequence_file_name_prefix = self.sequence_file_name[:-(len(self.sequence_file_name_digits) + len(self.sequence_file_name_suffix))]

        print ('self.sequence_file_name_prefix: ', self.sequence_file_name_prefix)
        print ('len of self.sequence_file_name_digits: ', len(self.sequence_file_name_digits))
        print ('self.sequence_file_name_digits: ', self.sequence_file_name_digits)
        print ('self.sequence_file_name_suffix: ', self.sequence_file_name_suffix)

        # select sequence files by mask
        self.sequence_mask = self.sequence_file_name_prefix  +  '?'*len(self.sequence_file_name_digits)  +  self.sequence_file_name_suffix  +  '.' + self.sequence_extension
        self.sequence_files = glob.glob(os.path.join(self.sequence_folder,self.sequence_mask))
        for self.i, self.item in enumerate(self.sequence_files):
            self.sequence_files[self.i] = os.path.basename(self.sequence_files[self.i])
        print('glob mask:', os.path.join(self.sequence_folder,self.sequence_mask))

        print('self.sequence_mask: ', self.sequence_mask)
        print('length of self.sequence_files: ', len(self.sequence_files))
        print('self.sequence_files: ', self.sequence_files)

        # sequence_numbers from file names
        for self.i, self.item in enumerate(self.sequence_files):
            self.sequence_numbers.append(int(self.sequence_files[self.i][len(self.sequence_file_name_prefix):-(4 + len(self.sequence_file_name_suffix))]))

        print('length of self.sequence_numbers', len(self.sequence_numbers))
        print('self.sequence_numbers', self.sequence_numbers)

        # check length of sequence
        if len(self.sequence_numbers) < 2:
            self.print_message = 'Error: Sequence consists of one file.'
            self.sequence_folder = ''
            self.sequence_mask = ''
            self.output_file_name = ''
            return

        # output file name
        if self.sequence_file_name_suffix == '':
            if re.search('[-_.]', self.sequence_file_name_prefix[-1]):
                self.output_file_name = self.sequence_file_name_prefix[:-1]
            else:
                self.output_file_name = self.sequence_file_name_prefix
        else:
            if re.search('[-_.]', self.sequence_file_name_prefix[-1]) and re.search('[-_.]', self.sequence_file_name_suffix[0]):
                self.output_file_name = self.sequence_file_name_prefix[:-1] + self.sequence_file_name_suffix + '.mp4'
            else:
                self.output_file_name = self.sequence_file_name_prefix + self.sequence_file_name_suffix + '.mp4'

    @Slot()
    def convert(self):
        self.ffmpeg_fps = self.config['main']['fps']
        self.ffmpeg_input = self.sequence_file_name_prefix + '%0' + str(len(self.sequence_file_name_digits)) + 'd' + self.sequence_file_name_suffix + '.' + self.sequence_extension
        self.ffmpeg_input = os.path.join(self.sequence_folder, self.ffmpeg_input)
        self.format_extensions = ["mp4", "mov", "mkv", "avi", "gif"]
        self.ffmpeg_output = self.output_file_name + '.' + self.format_extensions[int(self.config['main']['format'])]
        self.ffmpeg_output = os.path.join(self.sequence_folder, self.ffmpeg_output)
        self.ffmpeg_start_number = str(min(self.sequence_numbers))
        self.ffmpeg_exe_path = os.path.join(self.stvc_path, 'ffmpeg.exe')
        print('ffmpeg_fps: ', self.config['main']['fps'])
        print('ffmpeg_input: ', self.ffmpeg_input)
        print('ffmpeg_output: ', self.ffmpeg_output)
        print('ffmpeg_start_number: ', self.ffmpeg_start_number)
        print('self.ffmpeg_exe_path: ', self.ffmpeg_exe_path)


        # run ffmpeg
        subprocess.call([self.ffmpeg_exe_path,
                         '-framerate',
                         self.ffmpeg_fps,
                         '-start_number',
                         self.ffmpeg_start_number,
                         '-i',
                         self.ffmpeg_input,
                         '-vf',
                         'format=yuv420p',
                         self.ffmpeg_output])


    @Slot(str)
    def openFile(self,arg):
        self.AssignSequenceVariables(arg[8:])
        self.pathsForUI()

    @Slot()
    def pathsForUI(self):
        self.setSequence_mask.emit(self.sequence_mask)
        self.setSequence_folder.emit(self.sequence_folder)
        self.setOutput_file_name.emit(self.output_file_name)

    @Slot()
    def printLog(self):
        self.setPrintLog.emit(self.print_message)

    @Slot(int, int, int, int, int, int, int, str)
    def ui_values(self, fps, format, alpha, quality, bitrate, remove, change_output, output_path):
        self.config['main']['fps'] = str(fps)
        self.config['main']['format'] = str(format)
        self.config['main']['alpha'] = str(alpha)
        self.config['main']['quality'] = str(quality)
        self.config['main']['bitrate'] = str(bitrate)
        self.config['main']['remove'] = str(remove)
        self.config['main']['change_output'] = str(change_output)
        self.config['main']['output_path'] = str(output_path)

    @Slot()
    def save_settings_file(self):
        with open(os.path.join(os.path.dirname(sys.argv[0]), "settings.ini"), 'w') as f:
            self.config.write(f)
        self.print_message = "Settings Saved"
        self.printLog()

    @Slot()
    def defaultVal(self):
        self.setFps.emit(int(self.config['main']['fps']))
        self.setFormat.emit(int(self.config['main']['format']))
        self.setAlpha.emit(strtobool(self.config['main']['alpha']))
        self.setQuality.emit(int(self.config['main']['quality']))
        self.setBitrate.emit(int(self.config['main']['bitrate']))
        self.setRemove.emit(strtobool(self.config['main']['remove']))
        self.setChange_output.emit(strtobool(self.config['main']['change_output']))
        self.setOutput_path.emit(str(self.config['main']['output_path']))


if __name__ == "__main__":
    # print("---------------============ START =================--------------------")
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    main = MainWindow()
    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("backend", main)
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())

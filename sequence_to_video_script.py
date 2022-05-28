# converting sequence to video script
import sys
import subprocess
import os
import glob
import re


current_dir = os.getcwd()
file_name = sys.argv[1]
file_name_prefix = ''
file_name_digits = ''
file_name_suffix = ''
file_extension = sys.argv[2]
sequence_files = []
sequence_numbers = []

# lovercase file extension
file_extension = file_extension.lower()

# check if extension is correct
if (file_extension != 'jpg') and (file_extension != 'png'):
    print('Extension should be .JPG or .PNG')
    input("Press Enter")
    exit(0)
else:
    print("Extension - correct")

# number of digits at the end of filename (or in the middle)
file_name_reverse = file_name[::-1]
for i in file_name_reverse:
    if i.isdigit():
        file_name_digits += i
    else:
        if file_name_digits == '':
            file_name_suffix += i
            continue
        else:
            break
if file_name_digits == '':
    input('Error: No digits in filename. Press Enter to exit.')
    exit(0)
file_name_digits = file_name_digits[::-1]
file_name_suffix = file_name_suffix[::-1]
file_name_prefix = file_name[:-(len(file_name_digits) + len(file_name_suffix))]

print('file_name_prefix: ', file_name_prefix)
print('len of file_name_digits: ', len(file_name_digits))
print('file_name_digits: ', file_name_digits)
print('file_name_sufix: ', file_name_suffix)

# select sequence files by mask
mask = file_name_prefix  +  '?'*len(file_name_digits)  +  file_name_suffix  +  '.' + file_extension
sequence_files = glob.glob(mask)

print('mask: ', mask)
print('length of sequence_files: ', len(sequence_files))
print('sequence_files: ', sequence_files)

# sequense_numbers from file names
for i, item in enumerate(sequence_files):
    sequence_numbers.append(int(sequence_files[i][len(file_name_prefix):-(4 + len(file_name_suffix))]))

print('length of sequence_numbers', len(sequence_numbers))
print('sequence_numbers', sequence_numbers)

# asssigning ffmpeg variables
ffmpeg_fps = '24'
ffmpeg_input = file_name_prefix + '%0' + str(len(file_name_digits)) + 'd' + file_name_suffix + '.' + file_extension
# if file_name_suffix == '':
#     if re.search('[-_.]', file_name_prefix[-1]):
#         ffmpeg_output = file_name_prefix[:-1] + '.mp4'
#     else:
#         ffmpeg_output = file_name_prefix + '.mp4'
# else:
#     if re.search('[-_.]', file_name_prefix[-1]) and re.search('[-_.]', file_name_suffix[0]):
#         ffmpeg_output = file_name_prefix[:-1] + file_name_suffix + '.mp4'
#     else:
#         ffmpeg_output = file_name_prefix + file_name_suffix + '.mp4'
ffmpeg_start_number = str(min(sequence_numbers))

print('ffmpeg_fps: ', ffmpeg_fps)
print('ffmpeg_input: ', ffmpeg_input)
print('ffmpeg_output: ', ffmpeg_output)
print('ffmpeg_start_number: ', ffmpeg_start_number)

# run ffmpeg
subprocess.call(['ffmpeg', '-framerate', ffmpeg_fps, '-start_number', ffmpeg_start_number, '-i', ffmpeg_input, '-vf', 'format=yuv420p', ffmpeg_output])
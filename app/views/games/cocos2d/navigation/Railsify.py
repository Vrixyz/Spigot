import shutil

name = 'navigation'
srcFile = 'build/' + name + '.js'
destDir = '../../../../assets/javascripts/games/' + name + '/'
shutil.copyfile(srcFile, destDir + name + '.js')


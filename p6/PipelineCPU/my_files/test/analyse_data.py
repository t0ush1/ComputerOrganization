import os
import zipfile
import shutil

analysisPath = "D:\\study\\CO\\p6\\PipelineCPU\\my_files\\analysis\\"
codePath = "D:\\study\\CO\\p6\\PipelineCPU\\my_files\\test\\data\\code\\"
zfilePath = analysisPath + "work\\"

tot = 101

# remove existed zip and results
if os.path.exists(zfilePath + "P6_code.zip"):
    os.remove(zfilePath + "P6_code.zip")
if os.path.exists(zfilePath + "P6_code"):
    shutil.rmtree(zfilePath + "P6_code")

# gnrt zipfiles
with zipfile.ZipFile(zfilePath + "P6_code.zip", "w") as zfile:
    for i in range(0, tot):
        tmpzfileName = "code" + str(i) + ".zip"
        with zipfile.ZipFile(tmpzfileName, "w") as tmpzfile:
            tmpzfile.write(codePath + "code" + str(i) + ".txt", "code.txt")
        zfile.write(tmpzfileName)
        os.remove(tmpzfileName)

# run analyzer
os.chdir(analysisPath)
os.system("python analyzer.py")
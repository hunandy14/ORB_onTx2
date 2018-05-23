# cxx
CXX := g++
CXXFLAGS :=
# CXXFLAGS += -g
CXXFLAGS += -O3
CXXFLAGS += -std=c++14
# CXXFLAGS += -fopenmp

CXXLIB :=
CXXLIB += -I/home/nvidia/ORB_onTx2/ImgRaw/imglib
CXXLIB += -I/home/nvidia/ORB_onTx2/ImgRaw/Raw2Img
CXXLIB += -I/home/nvidia/ORB_onTx2/ImgRaw

CXXFLAGS += $(CXXLIB)
# =============================================
# make 預設執行
# =============================================
resule: main

# =============================================
# 編譯檔案命令 [tag:cmd]
# =============================================
# 連結所有編譯後的檔案產生可執行檔
main: main.o Raw2img.o imglib.o Imgraw.o
	$(CXX) $(CXXFLAGS) *.o -o main


# Main 檔案
main.o: main.cpp
	$(CXX) $(CXXFLAGS) -c main.cpp
# Raw2Img 檔案
Raw2img.o: ImgRaw/Raw2Img/Raw2img.cpp ImgRaw/Raw2Img/Raw2img.hpp ImgRaw/Raw2Img/Raw2img_type.hpp
	$(CXX) $(CXXFLAGS) -c ImgRaw/Raw2Img/Raw2img.cpp
# imglib 檔案
imglib.o: ImgRaw/imglib/imglib.cpp ImgRaw/imglib/imglib.hpp
	$(CXX) $(CXXFLAGS) -c ImgRaw/imglib/imglib.cpp
# # # imglib 檔案
Imgraw.o: ImgRaw/Imgraw.cpp ImgRaw/Imgraw.hpp
	$(CXX) $(CXXFLAGS) -c ImgRaw/Imgraw.cpp


# =============================================
# 命令列
# =============================================
# 清理所有編譯的檔案
clean:
	rm -f *.o OpenBMP_main
	rm -f obj/*.o OpenBMP_main
cleanimg:
	rm -f ImgOutput/*.bmp main
# 僅編譯出可執行檔，並清除緩存
run: resule
	./main
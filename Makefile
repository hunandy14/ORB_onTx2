# cxx
CXX := g++
CXXFLAGS :=
# CXXFLAGS += -g
CXXFLAGS += -O3
CXXFLAGS += -std=c++11
# CXXFLAGS += -fopenmp

CXXLIB :=
CXXLIB += `pkg-config opencv --libs`
CXXLIB += -IImgRaw/imglib
CXXLIB += -IImgRaw/Raw2Img
CXXLIB += -IImgRaw

CXXINC :=
CXXINC += `pkg-config opencv --cflags`
CXXFLAGS += $(CXXLIB) $(CXXINC)
# =============================================
# make 預設執行
# =============================================
resule: main

# =============================================
# 編譯檔案命令 [tag:cmd]
# =============================================
# 連結所有編譯後的檔案產生可執行檔
main: main.o Raw2img.o imglib.o Imgraw.o opencvTest.o
	$(CXX) *.o -o main $(CXXFLAGS)


# Main 檔案
main.o: main.cpp
	$(CXX) -c main.cpp $(CXXFLAGS)
# Raw2Img 檔案
Raw2img.o: ImgRaw/Raw2Img/Raw2img.cpp ImgRaw/Raw2Img/Raw2img.hpp ImgRaw/Raw2Img/Raw2img_type.hpp
	$(CXX) -c ImgRaw/Raw2Img/Raw2img.cpp $(CXXFLAGS)
# imglib 檔案
imglib.o: ImgRaw/imglib/imglib.cpp ImgRaw/imglib/imglib.hpp
	$(CXX) -c ImgRaw/imglib/imglib.cpp $(CXXFLAGS)
# imglib 檔案
Imgraw.o: ImgRaw/Imgraw.cpp ImgRaw/Imgraw.hpp
	$(CXX) -c ImgRaw/Imgraw.cpp $(CXXFLAGS)
# opencvTest 檔案
opencvTest.o: opencvTest.cpp opencvTest.hpp
	$(CXX) -c opencvTest.cpp $(CXXFLAGS)

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
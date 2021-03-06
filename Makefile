# cxx
CXX := nvcc
CXXFLAGS :=
CXXFLAGS += -O3
CXXFLAGS += -std=c++14
# CXXFLAGS += -fopenmp
# CXXFLAGS += -Xcompiler -fopenmp


CXXLIB := 
CXXLIB += -I/
CXXLIB += `pkg-config opencv --libs`
CXXLIB += -IImgRaw/imglib
CXXLIB += -IImgRaw/Raw2Img
CXXLIB += -IImgRaw
CXXLIB += -Ifeat
CXXLIB += -Iharris_coners
CXXLIB += -Ifastlib
CXXLIB += -Icubilinear
CXXLIB += -ILapBlend
CXXLIB += -ITimer

CXXINC :=
CXXINC += `pkg-config opencv --cflags`
CXXFLAGS += $(CXXLIB) $(CXXINC)

# =============================================
# 編譯檔案命令 [tag:cmd]
# =============================================
# 連結所有編譯後的檔案產生可執行檔
main.out: \
	main.o \
	Raw2img.o \
	imglib.o \
	Imgraw.o \
	opencvTest.o \
\
	ORB.o\
\
	feat.o \
	harris_coners.o \
	fastlib.o \
\
	getFocus.o\
	LapBlend.o\
	WarpPers.o\
\
	cubilinear.o\

	$(CXX) *.o -o main.out $(CXXFLAGS)
#  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
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

	
#  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# ORB 檔案
fastlib.o: fastlib/fastlib.cpp fastlib/fast.h
	$(CXX) -c fastlib/fastlib.cpp $(CXXFLAGS)
feat.o: feat/feat.cpp feat/feat.hpp
	$(CXX) -c feat/feat.cpp $(CXXFLAGS)
harris_coners.o: harris_coners/harris_coners.cpp harris_coners/harris_coners.hpp
	$(CXX) -c harris_coners/harris_coners.cpp $(CXXFLAGS)
ORB.o: ORB.cpp ORB.hpp
	$(CXX) -c ORB.cpp $(CXXFLAGS)

# LapBlend
getFocus.o: getFocus/getFocus.cpp getFocus/getFocus.hpp
	$(CXX) -c getFocus/getFocus.cpp $(CXXFLAGS)
WarpPers.o: WarpPers/WarpPers.cpp WarpPers/WarpPers.hpp
	$(CXX) -c WarpPers/WarpPers.cpp $(CXXFLAGS)
cubilinear.o: cubilinear/cubilinear.cu cubilinear/cubilinear.hpp
	$(CXX) -c cubilinear/cubilinear.cu $(CXXFLAGS)
LapBlend.o: LapBlend/LapBlend.cpp LapBlend/LapBlend.hpp
	$(CXX) -c LapBlend/LapBlend.cpp $(CXXFLAGS)

#  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# =============================================
# 命令列
# =============================================
# make 預設執行
resule: ./main.out
# 清理所有編譯的檔案
clean:
	rm -f *.o *.out
cleanimg:
	rm -f resultImg/*.bmp
# 僅編譯出可執行檔，並清除緩存
run: resule
	./main.out
rerun: clean resule
	./main.out
rebuild: clean resule
	./main.out
/*****************************************************************
Name :
Date : 2018/03/01
By   : CharlotteHonG
Final: 2018/03/19
*****************************************************************/
#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <bitset>
using namespace std;
#include <opencv2/opencv.hpp>
using namespace cv;
#include "Timer.hpp"
//====================================================================================
#include "opencvTest.hpp"
#include "ORB.hpp"
#include "ImgRaw/Imgraw.hpp"
#include "Imgraw.hpp"

void cvInitializeOpenCL() {
	cout << "cvInitializeOpenCL...\n";
	/*const ImgData img1("kanna.bmp");
	vector<LATCH::KeyPoint> key;
	HarrisCroner(key, img1.toConvertGray());*/
	
	using namespace cv;

	Mat cvImg(3, 3, CV_8U);
	UMat ugray = cvImg.getUMat(ACCESS_RW);

	vector<Point2f> corners;
	goodFeaturesToTrack(ugray, corners, 2000, 0.01, 3);
	cout << "cvInitializeOpenCL...done\n\n";
}
void imgStitch(string name1, string name2, string outName="__lapBlend.bmp", bool autoname=0) {
	static int num=0;
	// 開圖

	ImgRaw img1(name1, "", 0);
	ImgRaw img1_gray = img1.ConverGray();
	img1_gray.nomal=0;
	ImgRaw img2(name2, "", 0);
	ImgRaw img2_gray = img2.ConverGray();
	img2_gray.nomal=0;
	ImgRaw stackImg = imgMerge(img1, img2);
	ImgRaw imgL(name1);
	ImgRaw imgR(name2);

	basic_ImgData warpL, warpR, lapblend;
	ImgData_read(warpL, name1);
	ImgData_read(warpR, name2);
	// //====================================================================================
	Timer t1;
	Timer total;
	t1.priSta=1;
	// ORB
	Feat feat, feat2;
	t1.start();
	create_ORB(img1_gray, feat); // 0.25ms
	t1.print(" create_ORB1");

	t1.start();
	create_ORB(img2_gray, feat2); // 0.25ms
	t1.print(" create_ORB2");

	// 尋找配對點
	vector<double> HomogMat;
	t1.start();
	matchORB(feat2, feat, HomogMat); // 1ms
	t1.print(" matchORB");

	// // 測試配對點
	// stackImg.bmp("merge.bmp");
	// featDrawLine("line.bmp", stackImg, feat2);

	// // 縫合圖片
	size_t RANSAC_num=0;
	Feature** RANSAC_feat=nullptr;
	// RANSAC_feat = new Feature*[RANSAC_num];
	getNewfeat(feat2, RANSAC_feat, RANSAC_num);
	featDrawLine2("resultImg//_matchImg_RANSACImg"+to_string(num)+".bmp", stackImg, RANSAC_feat, RANSAC_num);



	//====================================================================================
	// 獲得偏差值
	int mx, my; double focals;
	t1.start();
	estimateFocal(HomogMat, focals); // 0ms
	t1.print(" getWarpFocal");
	t1.start();
	getWarpOffset(imgL, imgR, RANSAC_feat, RANSAC_num, mx, my, focals); // 0ms
	t1.print(" getWarpOffset");
	cout << "ft=" << focals << ", Ax=" << mx << ", Ay=" << my << ";  HogX="
	 << HomogMat[2] << ", HogY=" << HomogMat[5] << endl;



	// //====================================================================================
	t1.start();
	LapBlender(lapblend, warpL, warpR, focals, mx, my); // 22ms
	// WarpPers_Stitch(lapblend, warpL, warpR, HomogMat);
	t1.print(" LapBlender");
	cout << "=======================================" << endl;
	total.print("# total time"); // 93ms



	if (autoname) {
		outName = outName+to_string(num)+".bmp";
		cout << outName << endl;
		ImgData_write(lapblend, outName);
	}
	else {
		ImgData_write(lapblend, outName);
	}
	num++;
}
//====================================================================================
int main(int argc, char const *argv[]) {
	cvInitializeOpenCL();
	cout << "=!!======= run is good =======!!=" << endl;

	// imgStitch("srcImg//kanna.bmp", "srcImg//kanna90.bmp", "resultImg//_test.bmp");

	// imgStitch("srcImg//sc02.bmp", "srcImg//sc03.bmp", "resultImg//01.bmp");
	// imgStitch("srcImg//grail04.bmp", "srcImg//grail03.bmp", "resultImg////02.bmp");
	// imgStitch("srcImg//denny07.bmp", "srcImg//denny08.bmp", "resultImg////03.bmp");
	// imgStitch("srcImg//DSC_2958.bmp", "srcImg//DSC_2959.bmp", "resultImg////04.bmp");
	//imgStitch("srcImg//ball_01.bmp", "srcImg//ball_02.bmp", "resultImg//ball_01_blend.bmp");

	/*imgStitch("data//DSC_2936.bmp", "data//DSC_2937.bmp", "resultImg//blend", 1);
	imgStitch("data//DSC_2944.bmp", "data//DSC_2945.bmp", "resultImg//blend", 1);
	imgStitch("data//DSC_2952.bmp", "data//DSC_2953.bmp", "resultImg//blend", 1);
	imgStitch("data//DSC_2940.bmp", "data//DSC_2941.bmp", "resultImg//blend", 1);
	imgStitch("data//DSC_2958.bmp", "data//DSC_2959.bmp", "resultImg//blend", 1);
	imgStitch("data//DSC_2956.bmp", "data//DSC_2957.bmp", "resultImg//blend", 1);
	imgStitch("data//DSC_2938.bmp", "data//DSC_2939.bmp", "resultImg//blend", 1);
	imgStitch("data//DSC_2942.bmp", "data//DSC_2943.bmp", "resultImg//blend", 1);
	imgStitch("data//DSC_2946.bmp", "data//DSC_2947.bmp", "resultImg//blend", 1);

	imgStitch("data//DSC_2981.bmp", "data//DSC_2982.bmp", "resultImg//blend", 1);
	imgStitch("data//DSC_2984.bmp", "data//DSC_2983.bmp", "resultImg//blend", 1);*/

	// imgStitch("srcImg//ball_01.bmp", "srcImg//ball_02.bmp", "resultImg//ball_01_blend.bmp");
	// imgStitch("data2//ball01-1.bmp", "data2//ball01-2.bmp", "resultImg//01.bmp");
	// imgStitch("data2//ball02-1.bmp", "data2//ball02-2.bmp", "resultImg//02.bmp");
	imgStitch("data2//ball03-1.bmp", "data2//ball03-2.bmp", "resultImg//03.bmp");


	return 0;
}
//====================================================================================

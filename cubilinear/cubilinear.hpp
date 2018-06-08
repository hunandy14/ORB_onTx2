/*****************************************************************
Name : 
Date : 2018/01/08
By   : CharlotteHonG
Final: 2018/01/08
*****************************************************************/
#pragma once
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "CudaMem.cuh"
#include "Timer.hpp"
#include "Raw2img.hpp"

// struct basic_ImgData {
// 	std::vector<unsigned char> raw_img;
// 	uint32_t width;
// 	uint32_t height;
// 	uint16_t bits;
// };

__host__ void cuWarpScale_rgb(const basic_ImgData & src, basic_ImgData & dst, double ratio);
__host__ void WarpScale_rgb(const basic_ImgData & src, basic_ImgData & dst, double ratio);




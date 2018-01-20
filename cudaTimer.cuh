#pragma once
#include <iostream>

class cudaTimer
{
private:
    cudaEvent_t start;
    cudaEvent_t stop;
    cudaStream_t stream;
#define cudaSafeCall(call)  \
        do {\
            cudaError_t err = call;\
            if (cudaSuccess != err) \
            {\
                std::cerr << "CUDA error in " << __FILE__ << "(" << __LINE__ << "): " \
                    << cudaGetErrorString(err);\
                exit(EXIT_FAILURE);\
            }\
        } while(0)
public:
    cudaTimer()
    {
        cudaSafeCall(cudaEventCreate(&start));
        cudaSafeCall(cudaEventCreate(&stop));
    }

    ~cudaTimer()
    {
        cudaSafeCall(cudaEventDestroy(start));
        cudaSafeCall(cudaEventDestroy(stop));
    }

    void Start(cudaStream_t st = 0)
    {
        stream = st;
        cudaSafeCall(cudaEventRecord(start, stream));
    }

    float Stop()
    {
        float milliseconds = 0;
        cudaSafeCall(cudaEventRecord(stop, stream));
        cudaSafeCall(cudaEventSynchronize(stop));
        cudaSafeCall(cudaEventElapsedTime(&milliseconds, start, stop));
        return milliseconds;
    }
};

#include "cudaTimer.cuh"
#include <unistd.h>

int main()
{
    cudaTimer timer;
    timer.Start();
    sleep(3);
    std::cout << timer.Stop() << std::endl;
    return 0;
}

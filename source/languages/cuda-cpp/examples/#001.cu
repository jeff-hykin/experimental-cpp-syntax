// Kernel definition
__global__ void vectorAdd(const float *A, const float *B, float *C, int numElements)
 {
     int i = blockDim.x * blockIdx.x + threadIdx.x;

     if (i < numElements)
     {
         C[i] = A[i] + B[i];
     }
 }

 int main(void)
 {
     // Initialize some stuff...
     float *d_A = NULL;
     float *d_B = NULL;
     float *d_C = NULL;

     // Do some stuff...

     // Launch the kernel
     int numElements = 50000;
     int threadsPerBlock = 256;
     int blocksPerGrid =(numElements + threadsPerBlock - 1) / threadsPerBlock;

     vectorAdd<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_C, numElements);

     // Clean up...

     return 0;
 }

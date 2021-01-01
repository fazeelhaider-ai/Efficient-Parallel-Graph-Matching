
#include <stdio.h>
#include <stdlib.h>

__global__ void collateSegments_gpu(int * src, int * scanResult, int * output, int numEdges) {
	/*YOUR CODE HERE*/
int i;
int tid = blockIdx.x * blockDim.x + threadIdx.x;
int total_threads = blockDim.x * gridDim.x;

for(i = tid; i < numEdges; i += total_threads){
	if (src[i] != src[i+1]){
		output[src[i]] = scanResult[i];
	}
}
}

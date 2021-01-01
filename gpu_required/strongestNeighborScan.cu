
#include <stdio.h>
#include <stdlib.h>


__device__ int smallerDst (int a, int b){
	if(a < b){
	return a;
	}
	else {
	return b;
   }
} /*ending of device funtion  */
__global__ void strongestNeighborScan_gpu(int * src, int * oldDst, int * newDst, int * oldWeight, int * newWeight, int * madeChanges, int distance, int numEdges) {
	/*YOUR CODE HERE*/
int i;
int tid = blockIdx.x * blockDim.x + threadIdx.x;
int total_threads = blockDim.x * gridDim.x;

for(i = tid; i < numEdges; i += total_threads){

	if(tid >= numEdges){
		return;
	}

	if (src[i] == src[i-distance]){   /* if the element is in the same segment */
		if(oldWeight[i] == oldWeight[i-distance]){ /*if the two weights are equal */
				newDst[i] = smallerDst (oldDst[i], oldDst[i-distance]);
				newWeight[i] = oldWeight[i];
					
	} /*second if statement */
		else {
				newWeight[i] = max (oldWeight[i], oldWeight[i-distance]);
				if (newWeight[i] == oldWeight[i])
					newDst[i] = oldDst[i];
				if (newWeight[i] == oldWeight[i-distance])
					newDst[i] = oldDst[i-distance];
	}
	
} /*first if statement */
	else {
			newWeight[i] = oldWeight[i]; /* when the element is in a different segment, it takes its old weight as the new weight */
			newDst[i] = oldDst[i];
}
	if(oldDst[i] != newDst[i]){
		* madeChanges = 1;
}
}  /*ending of for loop */


}  /*ending of main  */



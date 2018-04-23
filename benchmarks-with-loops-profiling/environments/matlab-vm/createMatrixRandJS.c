
#include <mex.h>
#include <math.h>
#include <stdio.h>
#define MAXRND 0x7fffffff


unsigned int _common_seed = 49734321;

void common_srand(unsigned int seed) {
    _common_seed = seed;
}

int common_rand() {
    _common_seed = ((_common_seed + 0x7ed55d16) + (_common_seed << 12))  & 0xffffffff;
    _common_seed = ((_common_seed ^ 0xc761c23c) ^ (_common_seed >> 19))  & 0xffffffff;
    _common_seed = ((_common_seed + 0x165667b1) + (_common_seed << 5))   & 0xffffffff;
    _common_seed = ((_common_seed + 0xd3a2646c) ^ (_common_seed << 9))   & 0xffffffff;
    _common_seed = ((_common_seed + 0xfd7046c5) + (_common_seed << 3))   & 0xffffffff;
    _common_seed = ((_common_seed ^ 0xb55a4f09) ^ (_common_seed >> 16))  & 0xffffffff;
    return _common_seed;
}

double common_randJS() {
    return ((double) abs(common_rand()) / (double) MAXRND);
}

void createMatrixRandJS(double* m, int dim0, int dim1){
    int col, row;
    
    for(row=0; row<dim0; row++)
        for(col=0; col<dim1; col++){
            m[col*dim0+row] = common_randJS();
        }
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]){
    if(nrhs != 2){
        mexErrMsgIdAndTxt("createRandomPageMatrics:nrhs", "Two inputs required");
    }
    int dim0 = (int)mxGetScalar(prhs[0]);
    int dim1 = (int)mxGetScalar(prhs[1]);
    plhs[0] = mxCreateDoubleMatrix(dim0,dim1,mxREAL);
    double *m = mxGetPr(plhs[0]);
    createMatrixRandJS(m,dim0,dim1);
    return ;
}

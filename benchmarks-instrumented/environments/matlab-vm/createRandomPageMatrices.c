
#include <mex.h>
#include <math.h>
#include <stdio.h>

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

void random_pages(int n, int divisor, double *pages, double *noutlinks){
    int i, j, k;

    if (divisor <= 0) {
        fprintf(stderr, "ERROR: Invalid divisor '%d' for random initialization, divisor should be greater or equal to 1\n", divisor);
        exit(1);
    }

    for(i=0; i<n; ++i){
        noutlinks[i] = 0;
        for(j=0; j<n; ++j){
            if(i!=j && (abs(common_rand())%divisor == 0)){
                pages[i*n+j] = 1;
                noutlinks[i] += 1;
            } else {
                pages[i*n+j] = 0;
            }
        }

        if(noutlinks[i] == 0){
            do { k = abs(common_rand()) % n; } while ( k == i);
            pages[i*n + k] = 1;
            noutlinks[i] = 1;
        }
    }
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]){
    if(nrhs != 2){
        mexErrMsgIdAndTxt("createRandomPageMatrics:nrhs", "Two inputs required");
    }
    if(nlhs != 2){
        mexErrMsgIdAndTxt("createRandomPageMatrics:nlhs", "Two output required");
    }
    double n = mxGetScalar(prhs[0]);
    double divisor = mxGetScalar(prhs[0]);
    plhs[0] = mxCreateDoubleMatrix(n,n,mxREAL);
    plhs[1] = mxCreateDoubleMatrix(n,1,mxREAL);
    double *pages = mxGetPr(plhs[0]);
    double *noutlinks = mxGetPr(plhs[1]);
    random_pages(n,divisor,pages,noutlinks);
    return ;
}

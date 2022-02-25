# Riemann

<details>

* Version: 0.1.3
* GitHub: https://github.com/kisungyou/Riemann
* Source code: https://github.com/cran/Riemann
* Date/Publication: 2021-06-20 09:50:02 UTC
* Number of recursive dependencies: 112

Run `revdep_details(, "Riemann")` for more info

</details>

## In both

*   checking whether package ‘Riemann’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/paolo/Documents/github/usmap/revdep/checks.noindex/Riemann/new/Riemann.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘Riemann’ ...
** package ‘Riemann’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/Rcpp/include' -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/Rcpp/include' -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c auxiliary.cpp -o auxiliary.o
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/Rcpp/include' -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c distribution_grassmann.cpp -o distribution_grassmann.o
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/Rcpp/include' -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c distribution_sphere.cpp -o distribution_sphere.o
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/Rcpp/include' -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c distribution_spnorm.cpp -o distribution_spnorm.o
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/Rcpp/include' -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c functions_01_basic.cpp -o functions_01_basic.o
...
      ^
8 warnings generated.
clang++ -arch arm64 -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o Riemann.so RcppExports.o auxiliary.o distribution_grassmann.o distribution_sphere.o distribution_spnorm.o functions_01_basic.o functions_02_inference.o functions_03_clustering.o functions_03_clustering_criteria.o functions_05_visualization.o functions_06_curve.o functions_07_learning.o functions_special_others.o functions_special_spd.o riemann_general.o riemann_src.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/R/arm64/gfortran/lib/gcc/aarch64-apple-darwin20.2.0/11.0.0 -L/opt/R/arm64/gfortran/lib -lgfortran -lemutls_w -lm -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/R/arm64/gfortran/lib/gcc/aarch64-apple-darwin20.2.0/11.0.0'
ld: warning: directory not found for option '-L/opt/R/arm64/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [Riemann.so] Error 1
ERROR: compilation failed for package ‘Riemann’
* removing ‘/Users/paolo/Documents/github/usmap/revdep/checks.noindex/Riemann/new/Riemann.Rcheck/Riemann’


```
### CRAN

```
* installing *source* package ‘Riemann’ ...
** package ‘Riemann’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/Rcpp/include' -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/Rcpp/include' -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c auxiliary.cpp -o auxiliary.o
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/Rcpp/include' -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c distribution_grassmann.cpp -o distribution_grassmann.o
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/Rcpp/include' -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c distribution_sphere.cpp -o distribution_sphere.o
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/Rcpp/include' -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c distribution_spnorm.cpp -o distribution_spnorm.o
clang++ -arch arm64 -std=gnu++11 -I"/Library/Frameworks/R.framework/Resources/include" -DNDEBUG  -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/Rcpp/include' -I'/Users/paolo/Documents/github/usmap/revdep/library.noindex/Riemann/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2  -c functions_01_basic.cpp -o functions_01_basic.o
...
      ^
8 warnings generated.
clang++ -arch arm64 -std=gnu++11 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -single_module -multiply_defined suppress -L/Library/Frameworks/R.framework/Resources/lib -L/opt/R/arm64/lib -o Riemann.so RcppExports.o auxiliary.o distribution_grassmann.o distribution_sphere.o distribution_spnorm.o functions_01_basic.o functions_02_inference.o functions_03_clustering.o functions_03_clustering_criteria.o functions_05_visualization.o functions_06_curve.o functions_07_learning.o functions_special_others.o functions_special_spd.o riemann_general.o riemann_src.o -L/Library/Frameworks/R.framework/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Resources/lib -lRblas -L/opt/R/arm64/gfortran/lib/gcc/aarch64-apple-darwin20.2.0/11.0.0 -L/opt/R/arm64/gfortran/lib -lgfortran -lemutls_w -lm -F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation
ld: warning: directory not found for option '-L/opt/R/arm64/gfortran/lib/gcc/aarch64-apple-darwin20.2.0/11.0.0'
ld: warning: directory not found for option '-L/opt/R/arm64/gfortran/lib'
ld: library not found for -lgfortran
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [Riemann.so] Error 1
ERROR: compilation failed for package ‘Riemann’
* removing ‘/Users/paolo/Documents/github/usmap/revdep/checks.noindex/Riemann/old/Riemann.Rcheck/Riemann’


```

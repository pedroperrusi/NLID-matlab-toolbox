# Non Linear Systems Identification Toolbox
This respository was created on the purpose of utilizing NLID Toolbox, provided by Westwick and Kearney and described in their book — Identification of Nonlinear Physiological Systems. Their original files and book code are hosted in this repository.

### Compatibility
The procedure presented here was developed on a MATLAB 2016a OSX environment. Since then, a separate branch has been developed to port the code to a MATLAB 2018b Windows 64 bit environment. The code herein has not been tested for other operational systems or MATLAB versions, so compatibility is not guaranteed.

According to the toolbox README, some aspects of the toolbox were optimized by creating MEXfiles. Instructions to compile these files are given in the [README].txt. If your operating environment supports the provided MEX-files it is not necessary to rebuild them. 

> "Several of the more computationally intense routines are implemented as MEX files.  MEX files for Windows 32 bit, Linux and MAC OSX have been included in the archive's Master branch, and support for Windows 64 bit is included in the Win64 branch. Users of other operating systems will have to build these files themselves."

## Toolbox setup
For information about the setup, please refer to the file:
```
toolbox/nlid_tools/README.txt
```
These setup steps are according to the original toolbox documentation and adapted for the specific branch of the toolbox.

### Installation
* To install the Toolbox, clone the repository into your machine
```
git clone https://github.com/Perruci/NLID-matlab-toolbox.git
```
* Determine and check-out the appropriate branch for your operating environment. The Master branch is developed for MATLAB 2016a OSX, while the Win64 branch is developed for MATLAB 2018b Windows 64 bit.

* Open the repository in your file explorer, locate setup.m, and open it in MATLAB. Add the toolbox parent directory to the MATLAB path by typing the following in the MATLAB command window (replace $yourpath$ by the appropriate directory):
```
 cd $yourpath$/NLID-matlab-toolbox/
```

* Run [setup].m. This will add all directories that the toolbox needs to the MATLAB path. Depending on the branch, it will also ask you if you want to recompile the MEX-files.

### Testing the toolbox
There are several ways to verify the functioning of the toolbox. A good way to test if the setup was successful is to run one of the scripts from Westwick and Kearney's book. They're located at the folder:
```
 references/nlid_book/
```
Additionally, users are encouraged to run [nlid_demo].m (available in all branches) and [nlid_testall].m (available in the Win64 branch). The demo script will run through several of the model implementations in the toolbox and demonstrate their functionality and typical results. The testall-script runs all built-in testing scripts in order, to verify key functions of the toolbox.

## References
* Original files and references are presented [here](http://www.bme.mcgill.ca/reklab/manual/Common/NLID/index.shtm);
* Westwick and Kearney's book is avaliable for IEEE EMBS members on [IEEE Xplore](http://ieeexplore.ieee.org/xpl/bkabstractplus.jsp?bkn=5237251).

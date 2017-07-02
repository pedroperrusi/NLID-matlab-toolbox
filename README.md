# Non Linear Systems Identification Toolbox
This respository was created on the purpose of utilizing NLID Toolbox, provided by Westwick and Kearney and described on their book — Identification of Nonlinear Physiological Systems. Their original files and book code are disposed on this repository.

## Toolbox Setup
These setup steps were done accordingly to the Toolbox documentation and adapted for the repository. For more informations about the original steps, their instructions are is presented on the folder:
```
toolbox/nlid_tools/README.txt
```

### Compatibility
The procedure presented here was developed on a MATLAB 2016a OSX environment. It is not tested for other operational systems, or MATLAB versions.

According to the Toolbox README, the following operational systems performance were optimized by MEX files. Instructions to build them are presented on the [README](https://github.com/Perruci/NLID-matlab-toolbox/blob/master/toolbox/nlid_tools/README.txt), although it was not necessary.

> "Several of the more computationally intense routines are implemented
as MEX files.  MEX files for Windows, Linux and MAC OSX have been
included in the archive.  Users of other operating systems will have
to build these files themselves. "

### Installation
* To install the Toolbox, all you need to do is clone the repository into your machine
```
git clone https://github.com/Perruci/NLID-matlab-toolbox.git
```
* Open the repository on MATLAB. On MATLAB Command Window
```
 cd /path/to/NLID-matlab-toolbox/
```
* Then run _script.m_, which will add the Toolbox files to your MATLAB path, until you close it.

* **Note** that you need to run _script.m_ **every** time you open MATLAB software. As an alternative, you could add this routine to your _startup.m_ file. Read more about it [here](https://www.mathworks.com/help/matlab/ref/startup.html).

### Testing the Setup
A good way to test if the setup was successful is to run one of the scripts from Westwick and Kearney's book. They're located at the folder:
```
 references/nlid_book/
```
## References
* Original files and references are presented [here](http://www.bme.mcgill.ca/reklab/manual/Common/NLID/index.shtm);
* Westwick and Kearney's book is avaliable for IEEE EMBS members on [IEEE Xplore](http://ieeexplore.ieee.org/xpl/bkabstractplus.jsp?bkn=5237251).

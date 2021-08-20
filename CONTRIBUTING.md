****************************************************************************
SYNAPTUS - a Matlab/Octave toolbox for synthetic aperture ultrasound imaging
****************************************************************************

# BACKGROUND
The toolbox was originally written by Martin H. Skjelvareid, as a collection of algorithms developed during his work as a PhD candidate (see the PhD thesis in the "docs" folder). As with so many things, "the devil is in the details" when it comes practical implementation of synthetic aperture algorithms. The toolbox is meant to help people who are new to the field and are looking to make implementations of published algorithms. The toolbox could also represent a collection of reference methods against which new algorithms are compared.

The toolbox was made and published with the intention of sharing and collaborating on synthetic aperture algorithms with others. If you are working in the field and would like to contribute, please do so!


# COLLABORATION VIA GITHUB
The toolbox is distributed as a repository on GitHub. If you have comments or suggestions for improvements, you can create an issue (see https://guides.github.com/features/issues/ ) or contact Martin directly (see [UiT contact card](https://en.uit.no/ansatte/person?p_document_id=590060)). If you want to contribute code, download the toolbox using Git, make a branch where you can do changes, and open a pull request to add the changes to the "master" branch.


# ADDING NEW ALGORITHMS
- New algorithms should make a significant contribution to the toolbox, through one or more of the following:
  - Enabling synthetic aperture focusing in a new type of geometry or measurement mode.
  - Improving the performance of a pre-existing algorithm.
  - Demonstrating practical implementation of an interesting theoretical concept.
- A new algorithm should be added with a minimum of three .m-files: A general function for synthetic aperture processing (placed in the "core" folder), an example dataset, preferably in .mat-file format (placed in the "datasets" folder), and a test script which demonstrates the new function using the dataset.
- Try to keep the code compatible with both Matlab and Octave. Whichever platform you use for development, try running the code on the other platform as well, to root out problems due to small syntax differences etc.


# STYLE GUIDELINES
- Never use "magic numbers". Declare static variables at the beginning of the code file and refer to them by name later in the code.
- Structure the code using Matlab cells ('%%') for larger sections of code, and "headline" comments ('%') above smaller sections of code, also separated with a single empty line. Use comments directly behind code lines where extra clarification is necessary. Try
- Keep code text width below 80 characters (standard coding width). Break lines using '...' if necessary.
- White space: Convert tabs to spaces, to keep formatting consistent across editors (may have different tab spacing).
- Name the different versions of the ultrasonic data matrix in a way which indicates the dimensions of the different axes, and use large caps for the initial letter for matrices where one or more dimensions are in the Fourier domain.

Examples of variable naming:

|    Code variable     |     Represents wave field |
| -------------------- | ------------------------- |
|    ptxy              |     p(t,x,y)              |
|    Poxy              |     P(omega,x,y)          |
|    Pokxky            |     P(omega,k_x,k_y)      |
|    Pkxky_t0          |     P(t=0,k_x,k_y)        |

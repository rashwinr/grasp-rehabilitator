#Description of contents in the COI_DATA folder.
ATI folder: consists of data acquired from all the subjects utilizing Research-grade setup.

new device folder: consists of data acquired from all the subjects utilizing grasp rehabilitator.

Matlab scripts: Consists of 3 scripts.

newdevicedataprocessing.m is a single script consisting of two sections. Section 1 reads the data from the new device folder and Section 2 reads data from the ATI folder. For a single value of var(a variable in the script between 3 to 18), different subject folders will be opened to read data and generate plots (load force, grip force, peak grip force rate, peak load force rate etc.) PLFR and PGFR for ATI and GR are automatically extracted for different textures and weights and saved in variables PLFR_whole, PGFR_whole, PLFR_ATIwhole, and PGFR_ATIwhole. These are transferred to the Excel sheet for further processing.

importgraspdevicedata.m is a function that imports data into the Matlab environment from the saved text files.

plottingimages.m is a single script that has all the data for plots implemented in the paper.


Excel folder: consists of an excel file (Figures_DMD3242.xlsx) with 4 sheets.

Dataextract sheet: Consists of PLFR and PGFR extracted for each subject for different weight and textures.
Meanplot: Computes the PLFR and PGFR averages per subject per weight/texture. Plots are shown in Excel style, which is further copied to plottingmages.m for plotting in Matlab.
Figure 6 sheet: Provides steps and data for creation of Figure 6 in the paper.
Figure 7 & 9 sheet recreates the figures 7 and 9 from the sheet mean plot and provides equation 1.
Figure 8 & 10 sheet recreates the figure 8 and 10 from the sheet mean plot and provides equation 2.


Images Folder: Consists of images used in the paper.




Authors: Bradley E. Buchanan & Harold A. Rocha from the Department of Psychology at the University of South Florida

Description:
Vargin ERP Plotter is a quick function to plot APA quality ERP timeserieses in MatLab. The function asks to specify two processed grand-averaged .set files in your current working directory to plot. It then asks for you to specify the electrodes you wish to average from, the titles for the legend, the measurement window in ms, the sample rate, and the baseline (which is default -200).

Example Input:
VarginPlot('LRSP1.set','HRSP1.set',[65,69,70,83,84,90], 'LRS', 'HRS',[150,190],250,-600)

Prerequisites:
MATLAB
EEGLAB
ERPLAB

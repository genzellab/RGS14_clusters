%% Set up recording parameters and record
close all
openfig('veh_pca_3D.fig');

OptionZ.FrameRate=50;OptionZ.Duration=25;OptionZ.Periodic=false;
CaptureFigVid([-20,10;-110,10;-190,80;-290,10;-380,10],'veh_pca_3D',OptionZ)

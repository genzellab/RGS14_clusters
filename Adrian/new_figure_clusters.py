#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Sep 20 08:59:40 2024

@author: adrian
"""
import os
from scipy.io import loadmat

os.chdir('/home/adrian/Downloads')

# Load the .mat file
data = loadmat('mydata_pca_veh.mat')

# Extract variables from the loaded data
x_axis1 = data['x_axis1']
y_axis1 = data['y_axis1']
z_axis1 = data['z_axis1']
x_axis2 = data['x_axis2']
y_axis2 = data['y_axis2']
z_axis2 = data['z_axis2']
x_axis3 = data['x_axis3']
y_axis3 = data['y_axis3']
z_axis3 = data['z_axis3']
x_axis4 = data['x_axis4']
y_axis4 = data['y_axis4']
z_axis4 = data['z_axis4']

# %%
os.chdir('/home/adrian/Documents/GitHub/UMAP/utils/')
import plotting_helpers as hplt
import matplotlib.pyplot as plt

# Create a figure and axis beforehand
#fig, ax = plt.subplots()
figsize=(12,12)
fig = plt.figure(figsize=figsize)
ax = fig.add_subplot(projection='3d')
 
#[209/255 ,233/255, 196/255] light green
#[44/255, 210/255, 245/255] light blue
#[10/255, 75/255, 141/255] dark blue
#[0, 120/255, 0] green

#CLUSTER 3
hplt.plot_umap_rgs14clusters(x_axis1, y_axis1, z_axis1,color=[10/255, 75/255, 141/255],ax=ax)

#CLUSTER 4
hplt.plot_umap_rgs14clusters(x_axis2, y_axis2, z_axis2,ax=ax,color=[0, 120/255, 0])

#CLUSTER 2
hplt.plot_umap_rgs14clusters(x_axis3, y_axis3, z_axis3,ax=ax,color=[44/255, 210/255, 245/255])

# CLUSTER 1
hplt.plot_umap_rgs14clusters(x_axis4, y_axis4, z_axis4,ax=ax,color=[209/255 ,233/255, 196/255])

# Show the plot after plotting all clusters
plt.show()

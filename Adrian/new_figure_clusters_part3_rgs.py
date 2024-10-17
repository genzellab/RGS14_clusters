#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep 23 05:25:33 2024

@author: adrian
"""
import numpy as np
from scipy.stats import gaussian_kde
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib.animation import FuncAnimation
import os
from scipy.io import loadmat

os.chdir('/home/adrian/Downloads')

# Load the .mat file
#data = loadmat('mydata_pca_veh.mat')
data = loadmat('NEWmydata_pca_rgs.mat')

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

os.chdir('/home/adrian/Documents/GitHub/UMAP/utils/')

#%%
#1,4,3,2

# Remove NaNs for all clusters
#Cluster 1  31k
x_axis1 = x_axis1[~np.isnan(x_axis1)]
y_axis1 = y_axis1[~np.isnan(y_axis1)]
z_axis1 = z_axis1[~np.isnan(z_axis1)]
#Cluster 4  9k
x_axis2 = x_axis2[~np.isnan(x_axis2)]
y_axis2 = y_axis2[~np.isnan(y_axis2)]
z_axis2 = z_axis2[~np.isnan(z_axis2)]
#Cluster 3   6k
x_axis3 = x_axis3[~np.isnan(x_axis3)]
y_axis3 = y_axis3[~np.isnan(y_axis3)]
z_axis3 = z_axis3[~np.isnan(z_axis3)]
#Cluster 2   20k
x_axis4 = x_axis4[~np.isnan(x_axis4)]
y_axis4 = y_axis4[~np.isnan(y_axis4)]
z_axis4 = z_axis4[~np.isnan(z_axis4)]

# Set up figure and 3D axis
# fig = plt.figure(figsize=(10, 8))
# ax = fig.add_subplot(111, projection='3d')

# # Set up figure and create 1x2 subplot (1 row, 2 columns)
# fig = plt.figure(figsize=(15, 8))
# ax = fig.add_subplot(121, projection='3d')  # First subplot
# ax2 = fig.add_subplot(122, projection='3d')  # Second subplot
# # Set up figure and create 2x2 subplot (2 rows, 2 columns)

#fig = plt.figure(figsize=(15, 15))
##Create 4 subplots in a 2x2 grid
# ax = fig.add_subplot(221, projection='3d')  # First subplot
# ax2 = fig.add_subplot(222, projection='3d')  # Second subplot
# ax3 = fig.add_subplot(223, projection='3d')  # Third subplot
# ax4 = fig.add_subplot(224, projection='3d')  # Fourth subplot


# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno'] #plasma cividis
#cmaps = ['Blues', 'Greens', 'RdPu'] #plasma cividis
# 3,4,2,1

#cmaps = ['viridis','viridis','viridis','viridis']
#cmaps = ['inferno','inferno','inferno','inferno']


# Function to perform KDE and plot each cluster
def plot_cluster(x, y, z, cmap, ax):
    # Perform KDE
    kde = gaussian_kde(np.vstack([x, y]))
    
    # Plot 3D scatter
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

def plot_cluster_noKDE(x, y, z, ax):
    # Perform KDE
    #kde = gaussian_kde(np.vstack([x, y]))
    
    # Plot 3D scatter
    sc = ax.scatter(x, y, z, color='gray', alpha=0.1, rasterized=True)
        #scatter = ax.scatter(x, y, z, c=feature, alpha=alpha, s=s, color=color)
    return sc

# Set a seed for reproducibility
# np.random.seed(42)  # You can choose any integer value

# # Randomly sample 16000 unique indices
# indices = np.random.choice(len(x_axis4), size=16000, replace=False)

# # Use the sampled indices to create downsampled arrays
# x_downsampled = x_axis4[indices]
# y_downsampled = y_axis4[indices]
# z_downsampled = z_axis4[indices]


# # Plot all clusters on the same figure
# sc1 = plot_cluster(x_axis1, y_axis1, z_axis1, custom_cmps[0], ax)
# sc2 = plot_cluster(x_axis2, y_axis2, z_axis2, custom_cmps[1], ax)
# sc3 = plot_cluster(x_axis3, y_axis3, z_axis3, custom_cmps[2], ax)
# #sc4 = plot_cluster(x_axis4, y_axis4, z_axis4, cmaps[3], ax)
# sc4 = plot_cluster(x_downsampled, y_downsampled, z_downsampled, custom_cmps[3], ax)

# Plot all clusters on the same figure
sc5 = plot_cluster(x_axis1, y_axis1, z_axis1, cmaps[2], ax3) # Cluster 1
sc6 = plot_cluster(x_axis2, y_axis2, z_axis2, cmaps[1], ax3) # Cluster 2
sc7 = plot_cluster(x_axis3, y_axis3, z_axis3, cmaps[0], ax3) # Cluster 3
sc8 = plot_cluster_noKDE(x_axis4, y_axis4, z_axis4,  ax3) #Cluster 4

#sc4 = plot_cluster(x_downsampled, y_downsampled, z_downsampled, cmaps[2], ax)


# Customize plot
ax3.set_title('RGS14 (Clusters)',fontsize=12)
ax3.set_xlabel('PCA1')
ax3.set_ylabel('PCA2')
ax3.set_zlabel('PCA3')

#ax.set_xlim(-20,20)
#ax.set_ylim(-10,10)
###ax.set_zlim(0,10)
ax3.set_xlim(-10,35)
ax3.set_ylim(-10,12)
ax3.set_zlim(-7.770710858935466, 20)


# Add colorbars for each cluster
#fig.colorbar(sc2, ax=ax, label='KDE Cluster 4')
fig.colorbar(sc7, ax=ax3, label='KDE Cluster 3')
fig.colorbar(sc6, ax=ax3, label='KDE Cluster 2')
fig.colorbar(sc5, ax=ax3, label='KDE Cluster 1')

ax3.view_init(azim=180,elev=20)
# Set font size for axis labels
ax3.set_xlabel("PCA1", fontsize=10)
ax3.set_ylabel("PCA2", fontsize=10)
ax3.set_zlabel("PCA3", fontsize=10)

ax3.tick_params(axis='x', labelsize=10)  # X-axis tick font size
ax3.tick_params(axis='y', labelsize=10)  # Y-axis tick font size
ax3.tick_params(axis='z', labelsize=10)  # Y-axis tick font size
plt.rcParams.update({'font.size': 10})  # Set global font size

# Set custom ticks for each axis
ax3.set_xticks([-10, 0, 10, 20, 30])  # For the X-axis
ax3.set_yticks([-10, -5, 0, 5, 10])   # For the Y-axis
ax3.set_zticks([0, 10, 20])           # For the Z-axis

# Optionally, you can also set the tick labels (if needed)
# ax.set_xticklabels(['-10', '0', '10', '20', '30'])
# ax.set_yticklabels(['-10', '-5', '0', '5', '10'])
# ax.set_zticklabels(['0', '10', '20'])
#ax.grid(False)

plt.draw()  # Update the plot with new ticks
#%%
# Combine clusters 1,2 and 3. Amount of ripples per cluster is similar.
x = np.concatenate((x_axis1, x_axis3,x_axis2), axis=0)
y = np.concatenate((y_axis1, y_axis3,y_axis2), axis=0)
z = np.concatenate((z_axis1, z_axis3,z_axis2), axis=0)

cmaps = ['inferno'] #, 'plasma', 'inferno',plasma cividis

# Plot clusters on the third subplot (ax3)
sc11 = plot_cluster(x, y, z, cmaps[0], ax4)  # Cluster 3
sc12 = plot_cluster_noKDE(x_axis4, y_axis4, z_axis4, ax4)  # Cluster 4

# Customize ax3 plot
ax4.set_title('RGS14 (All ripples)',fontsize=12)  # Title for ax3
ax4.set_xlabel('PCA1', fontsize=10)
ax4.set_ylabel('PCA2', fontsize=10)
ax4.set_zlabel('PCA3', fontsize=10)

# Set axis limits for ax3
ax4.set_xlim(-10, 35)
ax4.set_ylim(-10, 12)
ax4.set_zlim(-7.770710858935466, 20)

# Add colorbar for the first cluster in ax3
fig.colorbar(sc11, ax=ax4, label='KDE All ripples')  # Add colorbar for sc1
fig.colorbar(sc11, ax=ax4, label='KDE All ripples')  # Add colorbar for sc1
fig.colorbar(sc11, ax=ax4, label='KDE All ripples')  # Add colorbar for sc1

# Set view angle for ax3
ax4.view_init(azim=180, elev=20)

# Optional: Set ticks and grid
ax4.tick_params(axis='x', labelsize=10)  # X-axis tick font size
ax4.tick_params(axis='y', labelsize=10)  # Y-axis tick font size
ax4.tick_params(axis='z', labelsize=10)  # Z-axis tick font size
ax4.grid(True)  # Enable grid for ax3

ax4.set_xticks([-10, 0, 10, 20, 30])  # For the X-axis
ax4.set_yticks([-10, -5, 0, 5, 10])   # For the Y-axis
ax4.set_zticks([0, 10, 20])           # For the Z-axis
#%%
# Assuming sc1, sc2, ..., sc12 are subplot image objects (e.g., from imshow)
for i, sc in enumerate([sc1, sc2, sc3, sc4, sc5, sc6, sc7, sc8, sc9, sc10, sc11, sc12], 1):
    print(f"sc{i} color limits: {sc.get_clim()}")
#%% New color limits


# Get the current color limits for sc1 and sc5
sc1_clim = sc1.get_clim()  # Color limits for sc1
sc5_clim = sc5.get_clim()  # Color limits for sc5

# Determine new lower and upper limits for sc1 and sc5
new_lower_limit_1_5 = min(sc1_clim[0], sc5_clim[0])
new_upper_limit_1_5 = max(sc1_clim[1], sc5_clim[1])

# Set the same limits for sc1 and sc7
sc1.set_clim(new_lower_limit_1_5, new_upper_limit_1_5)
sc5.set_clim(new_lower_limit_1_5, new_upper_limit_1_5)

# Repeat for sc2 and sc6
sc2_clim = sc2.get_clim()
sc6_clim = sc6.get_clim()

new_lower_limit_2_6 = min(sc2_clim[0], sc6_clim[0])
new_upper_limit_2_6 = max(sc2_clim[1], sc6_clim[1])

sc2.set_clim(new_lower_limit_2_6, new_upper_limit_2_6)
sc6.set_clim(new_lower_limit_2_6, new_upper_limit_2_6)

# Repeat for sc3 and sc7
sc3_clim = sc3.get_clim()
sc7_clim = sc7.get_clim()

new_lower_limit_3_7 = min(sc3_clim[0], sc7_clim[0])
new_upper_limit_3_7 = max(sc3_clim[1], sc7_clim[1])

sc3.set_clim(new_lower_limit_3_7, new_upper_limit_3_7)
sc7.set_clim(new_lower_limit_3_7, new_upper_limit_3_7)

# Get the current color limits for sc9 and sc11
sc9_clim = sc9.get_clim()  # Color limits for sc9
sc11_clim = sc11.get_clim()  # Color limits for sc11

# Determine new lower and upper limits for sc9 and sc11
new_lower_limit_9_11 = min(sc9_clim[0], sc11_clim[0])
new_upper_limit_9_11 = max(sc9_clim[1], sc11_clim[1])

# Set the same limits for sc9 and sc11
sc9.set_clim(new_lower_limit_9_11, new_upper_limit_9_11)
sc11.set_clim(new_lower_limit_9_11, new_upper_limit_9_11)

# Redraw the figures to apply changes
plt.draw()


#%%
ax = plt.gca()  # Get current axes;
# Extract font size
x_label_fontsize = ax.xaxis.label.get_size()
y_label_fontsize = ax.yaxis.label.get_size()
# For 3D plots:
z_label_fontsize = ax.zaxis.label.get_size()

print(f"X-axis label font size: {x_label_fontsize}")
print(f"Y-axis label font size: {y_label_fontsize}")
print(f"Z-axis label font size: {z_label_fontsize}")  # Uncomment for 3D plots
# font size: 10
#%%
ax = plt.gca()  # Get current axes

# Get font size of X-axis and Y-axis tick labels
x_tick_fontsize = ax.xaxis.get_ticklabels()[0].get_size()
y_tick_fontsize = ax.yaxis.get_ticklabels()[0].get_size()
z_tick_fontsize = ax.zaxis.get_ticklabels()[0].get_size()

print(f"X-axis tick label font size: {x_tick_fontsize}")
print(f"Y-axis tick label font size: {y_tick_fontsize}")
print(f"Z-axis tick label font size: {z_tick_fontsize}")
# font size: 10

#%%
angle=195
ax.view_init(azim=angle,elev=20)
ax2.view_init(azim=angle,elev=20)
ax3.view_init(azim=angle,elev=20)
ax4.view_init(azim=angle,elev=20)    

#%%

# Generate and save frames
for angle in range(0, 360, 5):  # Rotate every 2 degrees
    ax.view_init(azim=angle,elev=20)
    ax2.view_init(azim=angle,elev=20)
    ax3.view_init(azim=angle,elev=20)
    ax4.view_init(azim=angle,elev=20)    
    plt.savefig(f"frame_{angle}.png", dpi=300)  # Save each frame

#plt.close()
#%%

from moviepy.editor import ImageSequenceClip

# List of all the frame files
frames = [f"frame_{angle}.png" for angle in range(0, 360, 5)]

# Create a video clip
clip = ImageSequenceClip(frames, fps=1)

# Save the video
clip.write_videofile("rotating_3D_plot_v6.mp4", codec="mpeg4")


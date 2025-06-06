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
data = loadmat('NEWmydata_pca_veh.mat')
#data = loadmat('mydata_pca_rgs.mat')

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


# Remove NaNs for all clusters
#Cluster 3
x_axis1 = x_axis1[~np.isnan(x_axis1)]
y_axis1 = y_axis1[~np.isnan(y_axis1)]
z_axis1 = z_axis1[~np.isnan(z_axis1)]
#Cluster 4
x_axis2 = x_axis2[~np.isnan(x_axis2)]
y_axis2 = y_axis2[~np.isnan(y_axis2)]
z_axis2 = z_axis2[~np.isnan(z_axis2)]
#Cluster 2
x_axis3 = x_axis3[~np.isnan(x_axis3)]
y_axis3 = y_axis3[~np.isnan(y_axis3)]
z_axis3 = z_axis3[~np.isnan(z_axis3)]
#Cluster 1
x_axis4 = x_axis4[~np.isnan(x_axis4)]
y_axis4 = y_axis4[~np.isnan(y_axis4)]
z_axis4 = z_axis4[~np.isnan(z_axis4)]
#%%
# Set up figure and 3D axis
#fig = plt.figure(figsize=(10, 8))
#ax = fig.add_subplot(111, projection='3d')

# # Set up figure and create 1x2 subplot (1 row, 2 columns)
#fig = plt.figure(figsize=(15, 8))
#ax = fig.add_subplot(121, projection='3d')  # First subplot
# ax2 = fig.add_subplot(122, projection='3d')  # Second subplot
# Set up figure and create 2x2 subplot (2 rows, 2 columns)

#fig = plt.figure(figsize=(15, 15))
fig = plt.figure(figsize=(15, 7.5))
# Create 4 subplots in a 2x2 grid
# ax = fig.add_subplot(221, projection='3d')  # First subplot
# ax2 = fig.add_subplot(222, projection='3d')  # Second subplot
# ax3 = fig.add_subplot(223, projection='3d')  # Third subplot
# ax4 = fig.add_subplot(224, projection='3d')  # Fourth subplot
ax = fig.add_subplot(221, projection='3d')  # First subplot
ax2 = fig.add_subplot(222, projection='3d')  # Second subplot


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

def find_peak_density_coords(x, y, z):
    # Perform 2D KDE on x and y
    kde = gaussian_kde(np.vstack([x, y]))
    density = kde(np.vstack([x, y]))
    
    # Get the index of the point with the highest density
    max_idx = np.argmax(density)
    
    # Return the corresponding (x, y, z) coordinates
    return x[max_idx], y[max_idx], z[max_idx]

# Set a seed for reproducibility
# np.random.seed(42)  # You can choose any integer value

# # Randomly sample 16000 unique indices
# indices = np.random.choice(len(x_axis4), size=16000, replace=False)

# # Use the sampled indices to create downsampled arrays
#x_downsampled = x_axis4[indices]
#y_downsampled = y_axis4[indices]
#z_downsampled = z_axis4[indices]
# x_downsampled = x_axis4
# y_downsampled = y_axis4
# z_downsampled = z_axis4

# # Plot all clusters on the same figure
# sc1 = plot_cluster(x_axis1, y_axis1, z_axis1, custom_cmps[0], ax)
# sc2 = plot_cluster(x_axis2, y_axis2, z_axis2, custom_cmps[1], ax)
# sc3 = plot_cluster(x_axis3, y_axis3, z_axis3, custom_cmps[2], ax)
# #sc4 = plot_cluster(x_axis4, y_axis4, z_axis4, cmaps[3], ax)
# sc4 = plot_cluster(x_downsampled, y_downsampled, z_downsampled, custom_cmps[3], ax)

# Plot all clusters on the same figure
sc1 = plot_cluster(x_axis1, y_axis1, z_axis1, cmaps[2], ax) # Cluster 3
sc2 = plot_cluster(x_axis2, y_axis2, z_axis2, cmaps[1], ax)
sc3 = plot_cluster(x_axis3, y_axis3, z_axis3, cmaps[0], ax) # Cluster 2
#sc4 = plot_cluster_noKDE(x_axis4, y_axis4, z_axis4,  ax) #Cluster 4

#sc4 = plot_cluster(x_axis4, y_axis4, z_axis4, cmaps[3], ax) # Cluster 1
#sc4 = plot_cluster(x_downsampled, y_downsampled, z_downsampled, cmaps[2], ax)

# Customize plot
ax.set_title('VEH (Clusters)',fontsize=12)
ax.set_xlabel('PCA1')
ax.set_ylabel('PCA2')
ax.set_zlabel('PCA3')

#ax.set_xlim(-20,20)
#ax.set_ylim(-10,10)
###ax.set_zlim(0,10)
ax.set_xlim(-10,35)
ax.set_ylim(-10,12)
ax.set_zlim(-7.770710858935466, 10)


pos1 = ax.get_position()  # Get the position of the first subplot
cbar1 = fig.add_axes([pos1.x1 + 0.03, pos1.y0+0.05, 0.01, pos1.height-0.1])  # Position the colorbar next to ax
colorbar1 =fig.colorbar(sc1, cax=cbar1, label='KDE Cluster 1',shrink=0.1)

cbar2 = fig.add_axes([pos1.x1 + 0.08, pos1.y0+0.05, 0.01, pos1.height-0.1])  # Position the colorbar next to ax2
colorbar2 =fig.colorbar(sc2, cax=cbar2, label='KDE Cluster 2',shrink=0.1)

cbar3 = fig.add_axes([pos1.x1 + 0.12, pos1.y0+0.05, 0.01, pos1.height-0.1])  # Position the colorbar next to ax3
colorbar3 =fig.colorbar(sc3, cax=cbar3, label='KDE Cluster 3',shrink=0.1)

# cbar2.remove()

# cbar1.remove()

# cbar3.remove()

# Add colorbars for each cluster
# cbar3=fig.colorbar(sc3, ax=ax, label='KDE Cluster 3',shrink=0.5)

# cbar2=fig.colorbar(sc2, ax=ax, label='KDE Cluster 2',shrink=0.5)

# cbar1=fig.colorbar(sc1, ax=ax, label='KDE Cluster 1',shrink=0.5)

ax.view_init(azim=180,elev=20)
# Set font size for axis labels
ax.set_xlabel("PCA1", fontsize=10)
ax.set_ylabel("PCA2", fontsize=10)
ax.set_zlabel("PCA3", fontsize=10)

ax.tick_params(axis='x', labelsize=10)  # X-axis tick font size
ax.tick_params(axis='y', labelsize=10)  # Y-axis tick font size
ax.tick_params(axis='z', labelsize=10)  # Y-axis tick font size
plt.rcParams.update({'font.size': 10})  # Set global font size

# Set custom ticks for each axis
ax.set_xticks([-10, 0, 10, 20, 30])  # For the X-axis
ax.set_yticks([-10, -5, 0, 5, 10])   # For the Y-axis
ax.set_zticks([0, 10])           # For the Z-axis

# Optionally, you can also set the tick labels (if needed)
# ax.set_xticklabels(['-10', '0', '10', '20', '30'])
# ax.set_yticklabels(['-10', '-5', '0', '5', '10'])
# ax.set_zticklabels(['0', '10', '20'])
#ax.grid(False)

plt.draw()  # Update the plot with new ticks

# Find and print max density coordinates for each cluster
peak1 = find_peak_density_coords(x_axis1, y_axis1, z_axis1)
peak2 = find_peak_density_coords(x_axis2, y_axis2, z_axis2)
peak3 = find_peak_density_coords(x_axis3, y_axis3, z_axis3)

print("Cluster 1 peak density at:", peak1)
print("Cluster 2 peak density at:", peak2)
print("Cluster 3 peak density at:", peak3)

from scipy.io import savemat

# Organize the peak coordinates into a dictionary
peak_coords = {
    'peak1': np.array(peak1),  # Cluster 1
    'peak2': np.array(peak2),  # Cluster 2
    'peak3': np.array(peak3),  # Cluster 3
}

# Save to a .mat file
savemat('cluster_peak_coords.mat', peak_coords)

#%%
# Combine clusters 1,2 and 3. Amount of ripples per cluster is similar.
x = np.concatenate((x_axis1, x_axis3,x_axis2), axis=0)
y = np.concatenate((y_axis1, y_axis3,y_axis2), axis=0)
z = np.concatenate((z_axis1, z_axis3,z_axis2), axis=0)

cmaps = ['inferno'] #, 'plasma', 'inferno',plasma cividis

# Plot clusters on the third subplot (ax3)
sc9 = plot_cluster(x, y, z, cmaps[0], ax2)  # Cluster 3
#sc10 = plot_cluster_noKDE(x_axis4, y_axis4, z_axis4, ax2)  # Cluster 4

# Customize ax3 plot
ax2.set_title('VEH (All ripples)',fontsize=12)  # Title for ax3
ax2.set_xlabel('PCA1', fontsize=10)
ax2.set_ylabel('PCA2', fontsize=10)
ax2.set_zlabel('PCA3', fontsize=10)

# Set axis limits for ax3
ax2.set_xlim(-10, 35)
ax2.set_ylim(-10, 12)
ax2.set_zlim(-7.770710858935466, 10)

pos1 = ax2.get_position()  # Get the position of the first subplot
cbar10 = fig.add_axes([pos1.x1 + 0.03, pos1.y0+0.05, 0.01, pos1.height-0.1])  # Position the colorbar next to ax
colorbar10 =fig.colorbar(sc9, cax=cbar10, label='KDE All ripples',shrink=0.1)

# # Add colorbar for the first cluster in ax3
# cbar10=fig.colorbar(sc9, ax=ax2, label='KDE All ripples',shrink=0.5)  # Add colorbar for sc1

# cbar8=fig.colorbar(sc9, ax=ax2, label='KDE All ripples',shrink=0.5)  # Add colorbar for sc1

# cbar9=fig.colorbar(sc9, ax=ax2, label='KDE All ripples',shrink=0.5)  # Add colorbar for sc1

# Set view angle for ax3
ax2.view_init(azim=180, elev=20)

# Optional: Set ticks and grid
ax2.tick_params(axis='x', labelsize=10)  # X-axis tick font size
ax2.tick_params(axis='y', labelsize=10)  # Y-axis tick font size
ax2.tick_params(axis='z', labelsize=10)  # Z-axis tick font size
ax2.grid(True)  # Enable grid for ax3

ax2.set_xticks([-10, 0, 10, 20, 30])  # For the X-axis
ax2.set_yticks([-10, -5, 0, 5, 10])   # For the Y-axis
ax2.set_zticks([0, 10])           # For the Z-axis


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

# # Generate and save frames
# for angle in range(0, 360, 5):  # Rotate every 2 degrees
#     ax.view_init(azim=angle,elev=30)
#     ax2.view_init(azim=angle,elev=30)
#     plt.savefig(f"frame_{angle}.png", dpi=300)  # Save each frame

# plt.close()
# #%%

# from moviepy.editor import ImageSequenceClip

# # List of all the frame files
# frames = [f"frame_{angle}.png" for angle in range(0, 360, 10)]

# # Create a video clip
# clip = ImageSequenceClip(frames, fps=5)

# # Save the video
# clip.write_videofile("rotating_3D_plot.mp4", codec="mpeg4")


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

# Set up figure and 3D axis
fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection='3d')

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
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4)
    return sc

def plot_cluster_noKDE(x, y, z, ax):
    # Perform KDE
    #kde = gaussian_kde(np.vstack([x, y]))
    
    # Plot 3D scatter
    sc = ax.scatter(x, y, z, color='gray', alpha=0.1)
        #scatter = ax.scatter(x, y, z, c=feature, alpha=alpha, s=s, color=color)
    return sc

# Set a seed for reproducibility
np.random.seed(42)  # You can choose any integer value

# Randomly sample 16000 unique indices
indices = np.random.choice(len(x_axis4), size=16000, replace=False)

# Use the sampled indices to create downsampled arrays
x_downsampled = x_axis4[indices]
y_downsampled = y_axis4[indices]
z_downsampled = z_axis4[indices]

# # Plot all clusters on the same figure
# sc1 = plot_cluster(x_axis1, y_axis1, z_axis1, custom_cmps[0], ax)
# sc2 = plot_cluster(x_axis2, y_axis2, z_axis2, custom_cmps[1], ax)
# sc3 = plot_cluster(x_axis3, y_axis3, z_axis3, custom_cmps[2], ax)
# #sc4 = plot_cluster(x_axis4, y_axis4, z_axis4, cmaps[3], ax)
# sc4 = plot_cluster(x_downsampled, y_downsampled, z_downsampled, custom_cmps[3], ax)

# Plot all clusters on the same figure
sc1 = plot_cluster(x_axis1, y_axis1, z_axis1, cmaps[0], ax) # Cluster 3
sc2 = plot_cluster_noKDE(x_axis2, y_axis2, z_axis2,  ax) #Cluster 4
sc3 = plot_cluster(x_axis3, y_axis3, z_axis3, cmaps[1], ax) # Cluster 2
#sc4 = plot_cluster(x_axis4, y_axis4, z_axis4, cmaps[3], ax) # Cluster 1
sc4 = plot_cluster(x_downsampled, y_downsampled, z_downsampled, cmaps[2], ax)


# Customize plot
ax.set_title('3D Kernel Density Estimation for Clusters')
ax.set_xlabel('PCA1')
ax.set_ylabel('PCA2')
ax.set_zlabel('PCA3')

ax.set_xlim(-20,20)
ax.set_ylim(-10,10)
##ax.set_zlim(0,10)

# Add colorbars for each cluster
fig.colorbar(sc1, ax=ax, label='KDE Cluster 3')
#fig.colorbar(sc2, ax=ax, label='KDE Cluster 4')
fig.colorbar(sc3, ax=ax, label='KDE Cluster 2')
fig.colorbar(sc4, ax=ax, label='KDE Cluster 1')

# Generate and save frames
for angle in range(0, 360, 18):  # Rotate every 2 degrees
    ax.view_init(azim=angle)
    plt.savefig(f"frame_{angle}.png", dpi=300)  # Save each frame

plt.close()

from moviepy.editor import ImageSequenceClip

# List of all the frame files
frames = [f"frame_{angle}.png" for angle in range(0, 360, 18)]

# Create a video clip
clip = ImageSequenceClip(frames, fps=5)

# Save the video
clip.write_videofile("rotating_3D_plot.mp4", codec="mpeg4")

# # Function to rotate the plot
# def rotate(angle):
#     ax.view_init(azim=angle)

# # Animate the rotation
# ani = FuncAnimation(fig, rotate, frames=np.arange(0, 360, 2), interval=50)

# # Save the animation as an MP4 file
# ani.save('rotating_3D_cluster_plot.mp4', writer='ffmpeg', fps=30)

# plt.show()

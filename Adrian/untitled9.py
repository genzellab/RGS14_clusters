#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Oct 22 21:11:14 2024

@author: adrian
"""
import plotly.tools as tls
import plotly.io as pio

plotly_fig=tls.mpl_to_plotly(fig)
pio.write_html(plotly_fig, file='3d_plot.html', auto_open=True)

#%%

from mpl_toolkits.mplot3d import Axes3D
import mpld3

mpld3.save_html(fig, '3d_plot.html')
#%%

fig = plt.figure(figsize=(15, 15))
# Create 4 subplots: 2x2 grid
ax_3d_1 = fig.add_subplot(221, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(222, projection='3d')  # Second subplot (3D)

ax_2d_1 = fig.add_subplot(223)  # First subplot (2D)
ax_2d_2 = fig.add_subplot(224)  # Second subplot (2D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno'] 

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Function to perform KDE and plot contours (2D)
def plot_cluster_2d(x, y, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    
    # Create a grid over the x and y range
    xgrid = np.linspace(x.min(), x.max(), 100)
    ygrid = np.linspace(y.min(), y.max(), 100)
    X, Y = np.meshgrid(xgrid, ygrid)
    Z = kde(np.vstack([X.ravel(), Y.ravel()])).reshape(X.shape)
    
    # Plot contour
    contour = ax.contourf(X, Y, Z, levels=20, cmap=cmap)
    return contour

# Plot 3D clusters
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[2], ax_3d_1) 
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_1)
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[0], ax_3d_1)

# Plot 2D contour for each cluster
contour1 = plot_cluster_2d(x_axis1, y_axis1, cmaps[0], ax_2d_1)
contour2 = plot_cluster_2d(x_axis2, y_axis2, cmaps[1], ax_2d_2)

# Customize 3D plot
ax_3d_1.set_title('VEH (Clusters) 3D')
ax_3d_1.set_xlabel('PCA1')
ax_3d_1.set_ylabel('PCA2')
ax_3d_1.set_zlabel('PCA3')

# Customize 2D plot
ax_2d_1.set_title('Cluster 1 - 2D Contour')
ax_2d_2.set_title('Cluster 2 - 2D Contour')

# Colorbars for 2D plots
fig.colorbar(contour1, ax=ax_2d_1)
fig.colorbar(contour2, ax=ax_2d_2)

plt.tight_layout()
plt.show()

#%%
fig = plt.figure(figsize=(15, 15))
# Create 6 subplots: 3 for 3D and 3 for 2D (3x2 grid)
ax_3d_1 = fig.add_subplot(231, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(232, projection='3d')  # Second subplot (3D)
ax_3d_3 = fig.add_subplot(233, projection='3d')  # Third subplot (3D)

ax_2d_1 = fig.add_subplot(234)  # First subplot (2D)
ax_2d_2 = fig.add_subplot(235)  # Second subplot (2D)
ax_2d_3 = fig.add_subplot(236)  # Third subplot (2D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno']

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Function to perform KDE and plot contours (2D)
def plot_cluster_2d(x, y, cmap, ax, xlim=None, ylim=None):
    kde = gaussian_kde(np.vstack([x, y]))
    
    # Create a grid over the x and y range
    xgrid = np.linspace(x.min(), x.max(), 100)
    ygrid = np.linspace(y.min(), y.max(), 100)
    X, Y = np.meshgrid(xgrid, ygrid)
    Z = kde(np.vstack([X.ravel(), Y.ravel()])).reshape(X.shape)
    
    # Plot contour
    contour = ax.contourf(X, Y, Z, levels=20, cmap=cmap)
    
    # Set axis limits if provided
    if xlim:
        ax.set_xlim(xlim)
    if ylim:
        ax.set_ylim(ylim)
    
    return contour

# Find global xlim and ylim for the 2D plots
xlim = [min(x_axis1.min(), x_axis2.min(), x_axis3.min()), max(x_axis1.max(), x_axis2.max(), x_axis3.max())]
ylim = [min(y_axis1.min(), y_axis2.min(), y_axis3.min()), max(y_axis1.max(), y_axis2.max(), y_axis3.max())]

# Plot 3D clusters
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[0], ax_3d_1)  # Cluster 1
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_2)  # Cluster 2
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[2], ax_3d_3)  # Cluster 3

# Plot 2D contours for each cluster, using the same xlim and ylim
contour1 = plot_cluster_2d(x_axis1, y_axis1, cmaps[0], ax_2d_1, xlim=xlim, ylim=ylim)
contour2 = plot_cluster_2d(x_axis2, y_axis2, cmaps[1], ax_2d_2, xlim=xlim, ylim=ylim)
contour3 = plot_cluster_2d(x_axis3, y_axis3, cmaps[2], ax_2d_3, xlim=xlim, ylim=ylim)

# Customize 3D plots
ax_3d_1.set_title('Cluster 1 - 3D')
ax_3d_2.set_title('Cluster 2 - 3D')
ax_3d_3.set_title('Cluster 3 - 3D')

# Customize 2D plots
ax_2d_1.set_title('Cluster 1 - 2D Contour')
ax_2d_2.set_title('Cluster 2 - 2D Contour')
ax_2d_3.set_title('Cluster 3 - 2D Contour')

# Colorbars for 2D plots
fig.colorbar(contour1, ax=ax_2d_1)
fig.colorbar(contour2, ax=ax_2d_2)
fig.colorbar(contour3, ax=ax_2d_3)

plt.tight_layout()
plt.show()
#%%
fig = plt.figure(figsize=(15, 15))
# Create 6 subplots: 3 for 3D and 3 for 2D (3x2 grid)
ax_3d_1 = fig.add_subplot(231, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(232, projection='3d')  # Second subplot (3D)
ax_3d_3 = fig.add_subplot(233, projection='3d')  # Third subplot (3D)

ax_2d_1 = fig.add_subplot(234)  # First subplot (2D)
ax_2d_2 = fig.add_subplot(235)  # Second subplot (2D)
ax_2d_3 = fig.add_subplot(236)  # Third subplot (2D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno']

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Function to perform KDE and plot contours (2D)
def plot_cluster_2d(x, y, cmap, ax, xlim=None, ylim=None):
    kde = gaussian_kde(np.vstack([x, y]))
    
    # Create a grid over the x and y range
    xgrid = np.linspace(x.min(), x.max(), 100)
    ygrid = np.linspace(y.min(), y.max(), 100)
    X, Y = np.meshgrid(xgrid, ygrid)
    Z = kde(np.vstack([X.ravel(), Y.ravel()])).reshape(X.shape)
    
    # Plot contour
    contour = ax.contourf(X, Y, Z, levels=20, cmap=cmap)
    
    # Set axis limits if provided
    if xlim:
        ax.set_xlim(xlim)
    if ylim:
        ax.set_ylim(ylim)
    
    return contour

# Find global xlim, ylim for 2D plots and zlim for 3D plots
xlim = [min(x_axis1.min(), x_axis2.min(), x_axis3.min()), max(x_axis1.max(), x_axis2.max(), x_axis3.max())]
ylim = [min(y_axis1.min(), y_axis2.min(), y_axis3.min()), max(y_axis1.max(), y_axis2.max(), y_axis3.max())]
zlim = [min(z_axis1.min(), z_axis2.min(), z_axis3.min()), max(z_axis1.max(), z_axis2.max(), z_axis3.max())]

# Plot 3D clusters, using the same axis limits for all 3D plots
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[0], ax_3d_1)  # Cluster 1
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_2)  # Cluster 2
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[2], ax_3d_3)  # Cluster 3

# Set the same limits for all 3D subplots
for ax in [ax_3d_1, ax_3d_2, ax_3d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)
    ax.set_zlim(zlim)
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    ax.set_zlabel('PCA3')

# Plot 2D contours for each cluster, using the same xlim and ylim
contour1 = plot_cluster_2d(x_axis1, y_axis1, cmaps[0], ax_2d_1, xlim=xlim, ylim=ylim)
contour2 = plot_cluster_2d(x_axis2, y_axis2, cmaps[1], ax_2d_2, xlim=xlim, ylim=ylim)
contour3 = plot_cluster_2d(x_axis3, y_axis3, cmaps[2], ax_2d_3, xlim=xlim, ylim=ylim)

# Customize 3D plot titles
ax_3d_1.set_title('Cluster 1 - 3D')
ax_3d_2.set_title('Cluster 2 - 3D')
ax_3d_3.set_title('Cluster 3 - 3D')

# Customize 2D plot titles
ax_2d_1.set_title('Cluster 1 - 2D Contour')
ax_2d_2.set_title('Cluster 2 - 2D Contour')
ax_2d_3.set_title('Cluster 3 - 2D Contour')

# Add colorbars for 2D plots
fig.colorbar(contour1, ax=ax_2d_1)
fig.colorbar(contour2, ax=ax_2d_2)
fig.colorbar(contour3, ax=ax_2d_3)

plt.tight_layout()
plt.show()

#%%
import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde
import numpy as np

fig = plt.figure(figsize=(18, 10))
# Create 6 subplots: 3 for 3D and 3 for 2D (3x2 grid)
ax_3d_1 = fig.add_subplot(231, projection='3d')  # First subplot (3D)
ax_3d_2 = fig.add_subplot(232, projection='3d')  # Second subplot (3D)
ax_3d_3 = fig.add_subplot(233, projection='3d')  # Third subplot (3D)

ax_2d_1 = fig.add_subplot(234)  # First subplot (2D)
ax_2d_2 = fig.add_subplot(235)  # Second subplot (2D)
ax_2d_3 = fig.add_subplot(236)  # Third subplot (2D)

# List of colormaps for each cluster
cmaps = ['viridis', 'plasma', 'inferno']

# Function to perform KDE and plot each cluster (3D)
def plot_cluster_3d(x, y, z, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    sc = ax.scatter(x, y, z, c=kde(np.vstack([x, y])), cmap=cmap, alpha=0.4, rasterized=True)
    return sc

# Function to perform KDE and plot contours (2D)
def plot_cluster_2d(x, y, cmap, ax):
    kde = gaussian_kde(np.vstack([x, y]))
    
    # Create a grid over the x and y range
    xgrid = np.linspace(x.min(), x.max(), 100)
    ygrid = np.linspace(y.min(), y.max(), 100)
    X, Y = np.meshgrid(xgrid, ygrid)
    Z = kde(np.vstack([X.ravel(), Y.ravel()])).reshape(X.shape)
    
    # Plot contour
    contour = ax.contourf(X, Y, Z, levels=20, cmap=cmap)
    
    # Set labels for 2D plots
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    
    return contour

# Find global xlim, ylim for 2D plots and zlim for 3D plots
xlim = [min(x_axis1.min(), x_axis2.min(), x_axis3.min()), max(x_axis1.max(), x_axis2.max(), x_axis3.max())]
ylim = [min(y_axis1.min(), y_axis2.min(), y_axis3.min()), max(y_axis1.max(), y_axis2.max(), y_axis3.max())]
zlim = [min(z_axis1.min(), z_axis2.min(), z_axis3.min()), max(z_axis1.max(), z_axis2.max(), z_axis3.max())]

# Plot 3D clusters, using the same axis limits for all 3D plots
sc1 = plot_cluster_3d(x_axis1, y_axis1, z_axis1, cmaps[2], ax_3d_1)  # Cluster 1
sc2 = plot_cluster_3d(x_axis2, y_axis2, z_axis2, cmaps[1], ax_3d_2)  # Cluster 2
sc3 = plot_cluster_3d(x_axis3, y_axis3, z_axis3, cmaps[0], ax_3d_3)  # Cluster 3

# Set the same limits for all 3D subplots
for ax in [ax_3d_1, ax_3d_2, ax_3d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)
    ax.set_zlim(zlim)
    ax.set_xlabel('PCA1')
    ax.set_ylabel('PCA2')
    ax.set_zlabel('PCA3')

# Plot 2D contours for each cluster, using the same xlim and ylim
contour1 = plot_cluster_2d(x_axis1, y_axis1, cmaps[2], ax_2d_1)
contour2 = plot_cluster_2d(x_axis2, y_axis2, cmaps[1], ax_2d_2)
contour3 = plot_cluster_2d(x_axis3, y_axis3, cmaps[0], ax_2d_3)

# Ensure the same axis limits for all 2D plots
for ax in [ax_2d_1, ax_2d_2, ax_2d_3]:
    ax.set_xlim(xlim)
    ax.set_ylim(ylim)

# Customize 3D plot titles
ax_3d_1.set_title('Cluster 1 - 3D')
ax_3d_2.set_title('Cluster 2 - 3D')
ax_3d_3.set_title('Cluster 3 - 3D')

# Customize 2D plot titles
ax_2d_1.set_title('Cluster 1 - 2D Contour')
ax_2d_2.set_title('Cluster 2 - 2D Contour')
ax_2d_3.set_title('Cluster 3 - 2D Contour')

# Add colorbars for 2D plots
fig.colorbar(contour1, ax=ax_2d_1)
fig.colorbar(contour2, ax=ax_2d_2)
fig.colorbar(contour3, ax=ax_2d_3)

# Add some spacing to avoid label overlap
plt.tight_layout(pad=3.0)  # Adjust padding to avoid overlap
plt.show()

# Get the color limits of each contour
vmin1, vmax1rgs = contour1.get_clim()
vmin2, vmax2rgs = contour2.get_clim()
vmin3, vmax3rgs = contour3.get_clim()
# # Get the color limits of each contour
# vmin1, vmax1 = contour1.get_clim()
# vmin2, vmax2 = contour2.get_clim()
# vmin3, vmax3 = contour3.get_clim()
Vmax1=0.3
Vmax2=0.315
Vmax3=0.108
contour1.set_clim(vmin=0, vmax=Vmax1)
contour2.set_clim(vmin=0, vmax=Vmax2)
contour3.set_clim(vmin=0, vmax=Vmax3)



#%%

